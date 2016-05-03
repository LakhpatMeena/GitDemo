//
//  BTServiceAvailabilityDetailsViewController.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 20/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceAvailabilityDetailsViewController.h"
#import "BTAppFontFamily.h"
#import "BTServiceAvailabilityDetailsTableViewCell.h"
#import "BTAvailableServiceData.h"
#import <dispatch/dispatch.h>
#import "ASIHTTPRequest.h"

@interface BTServiceAvailabilityDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberInfoLabel;
@property (strong, nonatomic) IBOutlet UITableView *availableServicesTableView;
@property (nonatomic, strong) UIActivityIndicatorView *dataFetchingActivty;
@property (nonatomic, strong) UILabel *dataFetchingLabel;
@property (nonatomic, strong) NSArray *availableServiceDataArray;
@property (nonatomic, strong) NSArray *rowDataForFaultSummaryTableArray;
@property (nonatomic, strong) dispatch_queue_t backgroundQueue;

@end

@implementation BTServiceAvailabilityDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_sectionHeaderDataArray = [[NSMutableArray alloc] init];
    
    
    self.phoneNumberString = @"01322221066";
    _rowDataForFaultSummaryTableArray = [[NSMutableArray alloc] init];
    
    
    _backgroundQueue = dispatch_queue_create("fetchBTAPIData",NULL);
    
    //[self fetchFaultSummaryData];
    self.dataFetchingActivty = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.dataFetchingActivty.center = CGPointMake(160, 255);
    [self.view addSubview:self.dataFetchingActivty];
    [self.dataFetchingActivty startAnimating];
    
    self.dataFetchingLabel = [[UILabel alloc] init];
    self.dataFetchingLabel.frame = CGRectMake(60, self.dataFetchingActivty.frame.origin.y + self.dataFetchingActivty.frame.size.height + 8, 200, 18);
    self.dataFetchingLabel.text = @"fetching service summary...";
    self.dataFetchingLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    self.dataFetchingLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:17];
    self.dataFetchingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.dataFetchingLabel];
    
    //NSLog(@"%f",self.dataFetchingActivty.frame.size.height);
    
    
    self.headerView.frame = CGRectMake(0, -self.headerView.frame.size.height, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
    self.availableServicesTableView.delegate = self;
    self.availableServicesTableView.dataSource = self;
    self.availableServicesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.availableServicesTableView.backgroundColor = [UIColor clearColor];
    
    self.availableServicesTableView.frame = CGRectMake(0, self.view.frame.size.height, self.availableServicesTableView.frame.size.width, self.availableServicesTableView.frame.size.height);
    
    UINib *dataCell = [UINib nibWithNibName:@"BTServiceAvailabilityDetailsTableViewCell" bundle:nil];
    
    [self.availableServicesTableView registerNib:dataCell forCellReuseIdentifier:@"BTServiceAvailabilityDetailsTableViewCell"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[BTAppFontFamily getNewBTBoldFontOfSize:19]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.headerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];

    [self fetchFaultSummaryData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - alert view method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"canceling");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - table view methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.availableServiceDataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTServiceAvailabilityDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BTServiceAvailabilityDetailsTableViewCell" forIndexPath:indexPath];
    if (indexPath.row == ([self.availableServiceDataArray count]-1)) {
        [cell updateCellWithServiceData:self.availableServiceDataArray[indexPath.row] withCellDivider:NO];
    } else {
        [cell updateCellWithServiceData:self.availableServiceDataArray[indexPath.row] withCellDivider:YES];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


-(void)updateHeaderViewInfo
{
    NSMutableAttributedString *headerInfo = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You can choose from the following services at %@",self.phoneNumberString]];
    [headerInfo addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 46)];
    [headerInfo addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(46, self.phoneNumberString.length)];
    [headerInfo addAttribute:NSFontAttributeName value:[BTAppFontFamily getNewBTRegularFontOfSize:16] range:NSMakeRange(0, 46)];
    [headerInfo addAttribute:NSFontAttributeName value:[BTAppFontFamily getBTFontExtraBoldFontOfSize:18] range:NSMakeRange(46, self.phoneNumberString.length)];
    self.phoneNumberInfoLabel.attributedText = headerInfo;
    self.phoneNumberInfoLabel.numberOfLines = 2;
}

#pragma mark - fetch and process fault data methods

- (void)fetchFaultSummaryData
{
    //dispatch_async(_backgroundQueue, ^{
    
    NSString *requestString = [NSString stringWithFormat:@"https://btbsecure.business.bt.com/Services/Dispatcher.ashx?_callback=angular.callbacks._1&phoneNumber=%@&service=LineCheckV2-SpeedCheckNumber", self.phoneNumberString];
    NSLog(@"%@",requestString);
    NSURL *url = [NSURL URLWithString:requestString];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    dispatch_async(_backgroundQueue, ^{
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSData *fetchedData = [request responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fetchJsonDataFromAPIData:fetchedData];
            [self updateViewAfterGettingAvailableServiceData];
        });
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error in downloading data: %@",error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [self dismissScreenWithError:error.localizedDescription];
        });
    }];
    [request startAsynchronous];
    
    });
        
    /*NSError *error = nil;
    NSURLResponse *response;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"%@",error);
    NSLog(@"%@",response);
    
    
    
    //NSLog(@"%@",jresponseData);
    
    if (!error) {
        
        NSString *sdata = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",responseData);
        
        NSString *jdata = [sdata substringWithRange:NSMakeRange(21, [sdata length]-22)];
        
        //NSLog(@"%@",jdata);
        
        NSData *jresponseData = [jdata dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:jresponseData options:kNilOptions error:&error];
        if(error!=nil)
        {
            NSLog(@"%@",error);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.availableServiceDataArray = [self extractAvailableServiceDataFromJsonData:jsonData];
                [self.availableServicesTableView reloadData];
            });
        }
    } else {
        NSLog(@"%@",error);
    }
    });*/
}

- (void)dismissScreenWithError:(NSString *)errorString
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry for Incovenience" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)fetchJsonDataFromAPIData:(NSData *)fetchedData
{
    NSString *sdata = [[NSString alloc] initWithData:fetchedData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",responseData);
    
    NSString *jdata = [sdata substringWithRange:NSMakeRange(21, [sdata length]-22)];
    
    //NSLog(@"%@",jdata);
    
    NSError *error = nil;
    NSData *jresponseData = [jdata dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:jresponseData options:kNilOptions error:&error];
    if(error!=nil)
    {
        NSLog(@"%@",error);
    } else {
        self.availableServiceDataArray = [self extractAvailableServiceDataFromJsonData:jsonData];
    }
}

-(NSArray *)extractAvailableServiceDataFromJsonData:(NSDictionary *)jsonData
{
    //NSLog(@"%@", jsonData);
    
    NSLog(@"%@",[[jsonData valueForKey:@"options"] valueForKey:@"broadband"]);
    NSLog(@"%@",[[jsonData valueForKey:@"options"] valueForKey:@"fibre"]);
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSArray *broadbandData = [[jsonData valueForKey:@"options"] valueForKey:@"broadband"];
    for (NSDictionary *serviceDict in broadbandData) {
        NSLog(@"%@",serviceDict);
        NSLog(@"%@",[serviceDict objectForKey:@"isAvailable"]);
        if ([[serviceDict objectForKey:@"isAvailable"] boolValue]) {
            
            BTAvailableServiceData *serviceData = [[BTAvailableServiceData alloc] init];
            if ([[serviceDict objectForKey:@"name"] isEqualToString:@"basic"]) {
                [serviceData setServiceName:@"Broadband"];
                [serviceData setUsage:@"10GB"];
            } else if ([[serviceDict objectForKey:@"name"] isEqualToString:@"unlimited"]) {
                [serviceData setServiceName:@"Unlimited Broadband"];
                [serviceData setUsage:@"unlimited"];
            } else if ([[serviceDict objectForKey:@"name"] isEqualToString:@"premium"]) {
                [serviceData setServiceName:@"Premium Broadband"];
                [serviceData setUsage:@"unlimited"];
            }
            
            [serviceData setServiceCharge:[[[serviceDict objectForKey:@"price"] objectForKey:@"24"] objectForKey:@"broadband"]];
            [serviceData setHighDownSpeed:[serviceDict objectForKey:@"highDownSpeed"]];
            [serviceData setHighUpSpeed:[serviceDict objectForKey:@"highUpSpeed"]];
            [serviceData setLowDownSpeed:[serviceDict objectForKey:@"lowDownSpeed"]];
            [serviceData setLowUpSpeed:[serviceDict objectForKey:@"lowUpSpeed"]];
            
            [dataArray addObject:serviceData];
        }
    }
    
    NSArray *fibreData = [[jsonData valueForKey:@"options"] valueForKey:@"fibre"];
    for (NSDictionary *serviceDict in fibreData) {
        NSLog(@"%@",serviceDict);
        NSLog(@"%@",[serviceDict objectForKey:@"isAvailable"]);
        if ([[serviceDict valueForKey:@"isAvailable"] boolValue]) {
            BTAvailableServiceData *serviceData = [[BTAvailableServiceData alloc] init];
            if ([[serviceDict objectForKey:@"name"] isEqualToString:@"basic"]) {
                [serviceData setServiceName:@"Infinity"];
                [serviceData setUsage:@"50GB"];
            } else if ([[serviceDict objectForKey:@"name"] isEqualToString:@"unlimited"]) {
                [serviceData setServiceName:@"Unlimited Infinity"];
                [serviceData setUsage:@"unlimited"];
            } else if ([[serviceDict objectForKey:@"name"] isEqualToString:@"premium"]) {
                [serviceData setServiceName:@"Premium Infinity"];
                [serviceData setUsage:@"unlimited"];
            }
            
            [serviceData setServiceCharge:[[[serviceDict objectForKey:@"price"] objectForKey:@"24"] objectForKey:@"broadband"]];
            [serviceData setHighDownSpeed:[serviceDict objectForKey:@"highDownSpeed"]];
            [serviceData setHighUpSpeed:[serviceDict objectForKey:@"highUpSpeed"]];
            [serviceData setLowDownSpeed:[serviceDict objectForKey:@"lowDownSpeed"]];
            [serviceData setLowUpSpeed:[serviceDict objectForKey:@"lowUpSpeed"]];
            
            [dataArray addObject:serviceData];
        }
    }
    
    return dataArray;
}

- (void)updateViewAfterGettingAvailableServiceData
{
    [self.availableServicesTableView reloadData];
    NSLog(@"Data fetched successfully");
    NSLog(@"%d",[self.availableServiceDataArray count]);
    
    [self saveRecentlySearchedDataArray];
    
    //[self.availableServicesTableView reloadData];
    [self updateHeaderViewInfo];
    
    
    
    [self.dataFetchingActivty stopAnimating];
    self.dataFetchingActivty.hidden = YES;
    
    self.dataFetchingLabel.hidden = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.headerView.frame = CGRectMake(0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
        self.availableServicesTableView.frame = CGRectMake(0, self.headerView.frame.size.height, self.availableServicesTableView.frame.size.width, self.availableServicesTableView.frame.size.height);
    }];
}


/*-(NSArray *)buildDummyServiceDataForTableView
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    BTAvailableServiceData *data1 = [[BTAvailableServiceData alloc] init];
    [data1 setServiceName:@"Broadband"];
    [data1 setServiceCharge:@"10"];
    [data1 setDownloadSpeed:@"20Mbps"];
    [data1 setUploadSpeed:@"1Mbps"];
    [data1 setUsage:@"10GB"];
    [dataArray addObject:data1];
    
    BTAvailableServiceData *data2 = [[BTAvailableServiceData alloc] init];
    [data2 setServiceName:@"Unlimited Broadband"];
    [data2 setServiceCharge:@"17"];
    [data2 setDownloadSpeed:@"20Mbps"];
    [data2 setUploadSpeed:@"1Mbps"];
    [data2 setUsage:@"unlimited"];
    [dataArray addObject:data2];
    
    BTAvailableServiceData *data3 = [[BTAvailableServiceData alloc] init];
    [data3 setServiceName:@"Premium Broadband"];
    [data3 setServiceCharge:@"25"];   //£
    [data3 setDownloadSpeed:@"20Mbps"];
    [data3 setUploadSpeed:@"1Mbps"];
    [data3 setUsage:@"unlimited"];
    [dataArray addObject:data3];
    
    return dataArray;
}*/

- (void)saveRecentlySearchedDataArray
{
    NSMutableDictionary *searchData = [[NSMutableDictionary alloc] init];
    [searchData setObject:self.phoneNumberString forKey:@"phoneNumber"];
    [searchData setObject:[NSString stringWithFormat:@"%d",[self.availableServiceDataArray count]] forKey:@"availabilityInfo"];
    
    NSDate *current = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm:ss"];
    [searchData setObject:[dateFormatter stringFromDate:current] forKey:@"lastSearchedTime"];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"recentlySearchedDataArray"]];
    
    for ( NSMutableDictionary *searchedData in dataArray) {
        if ([[searchData valueForKey:@"phoneNumber"] isEqualToString:[searchedData valueForKey:@"phoneNumber"]]) {
            [dataArray removeObject:searchedData];
        }
    }
    [dataArray insertObject:searchData atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:dataArray forKey:@"recentlySearchedDataArray"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
