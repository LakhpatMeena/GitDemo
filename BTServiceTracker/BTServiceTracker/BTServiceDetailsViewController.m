//
//  BTServiceDetailsViewController.m
//  BTServiceTracker
//
//  Created by Lakhpat on 13/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceDetailsViewController.h"
#import "BTServiceDetailsTableViewCell.h"
#import "BTServiceDetailsTableSubSectionViewCellTableViewCell.h"
#import "BTServiceDetailsTableHeaderView.h"
#import "BTAppFontFamily.h"
#import "BTFaultData.h"

@interface BTServiceDetailsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *serviceIdDetailsTableView;
@property (weak, nonatomic) IBOutlet UILabel *serviceIdInfoLabel;

@property (nonatomic, strong) NSMutableArray *rowDataForFaultSummaryTableArray;
@property (nonatomic, strong) NSMutableArray *sectionHeaderDataArray;
@property (nonatomic, strong) NSMutableDictionary *recentlySearchedData;

@end

@implementation BTServiceDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.serviceIdString = @"01912630565";
    
    //table data view
    
    _sectionHeaderDataArray = [[NSMutableArray alloc] init];
    _rowDataForFaultSummaryTableArray = [[NSMutableArray alloc] init];
    _recentlySearchedData = [[NSMutableDictionary alloc] init];
    [self fetchFaultSummaryData];
    
    self.serviceIdDetailsTableView.delegate = self;
    self.serviceIdDetailsTableView.dataSource = self;
    self.serviceIdDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.serviceIdDetailsTableView.backgroundColor = [UIColor clearColor];
    
    UINib *dataCell = [UINib nibWithNibName:@"BTServiceDetailsTableViewCell" bundle:nil];
    UINib *subsectionCell = [UINib nibWithNibName:@"BTServiceDetailsTableSubSectionViewCellTableViewCell" bundle:nil];
    
    [self.serviceIdDetailsTableView registerNib:dataCell forCellReuseIdentifier:@"BTServiceDetailsTableViewCell"];
    [self.serviceIdDetailsTableView registerNib:subsectionCell forCellReuseIdentifier:@"BTServiceDetailsTableSubSectionViewCellTableViewCell"];
    
    self.headerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    
    self.serviceIdInfoLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:20];
    self.serviceIdInfoLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    self.serviceIdInfoLabel.Text = self.serviceIdString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightTextColor],NSFontAttributeName:[BTAppFontFamily getNewBTRegularFontOfSize:19]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

#pragma mark - table view methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionHeaderDataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowDataForFaultSummaryTableArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = _rowDataForFaultSummaryTableArray[indexPath.section][indexPath.row];
    NSString *cellType = [cellData valueForKey:@"cellType"];
    if ([cellType isEqualToString:@"subSectionHeaderCell"]) {
        BTServiceDetailsTableSubSectionViewCellTableViewCell *subsectionViewCell = [tableView dequeueReusableCellWithIdentifier:@"BTServiceDetailsTableSubSectionViewCellTableViewCell" forIndexPath:indexPath];
        [subsectionViewCell updateCellWithTitleLabel:[cellData valueForKey:@"subSectionHeaderTitle"]];
        return subsectionViewCell;
    }
    else {
        BTServiceDetailsTableViewCell *faultDetailCell = [tableView dequeueReusableCellWithIdentifier:@"BTServiceDetailsTableViewCell" forIndexPath:indexPath];
        BTFaultData *faultData = [cellData valueForKey:@"faultData"];
        faultDetailCell.statusLabel.text = [[faultData statusOnUI] uppercaseString];
        faultDetailCell.faultReferenceLabel.text = [faultData faultReference];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        NSString *date = [dateFormatter stringFromDate:[faultData reportedOn]];
        faultDetailCell.reportedOnLabel.text = [date uppercaseString];
        return faultDetailCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = _rowDataForFaultSummaryTableArray[indexPath.section][indexPath.row];
    NSString *cellType = [cellData valueForKey:@"cellType"];
    if ([cellType isEqualToString:@"subSectionHeaderCell"]) {
        return 30;
    }
    else {
        return 80;
        
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BTServiceDetailsTableHeaderView *headerView = [[BTServiceDetailsTableHeaderView alloc] init];
    [headerView updateHeaderViewWithFaultData:_sectionHeaderDataArray[section]];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

#pragma mark - fetch and process fault data methods

- (void)fetchFaultSummaryData
{
    
    
    NSString *requestString = [NSString stringWithFormat:@"https://secure.business.bt.com/api/FaultsList/GetFaultsList?serviceId=%@&format=json", self.serviceIdString];
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    NSError *error = nil;
    NSURLResponse *response;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"%@",error);
    NSLog(@"%@",response);
    
    if (!error) {
        NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        [self extractFaultDataFromJsonData:jsonData];
        NSLog(@"%@",jsonData);
    }
}

- (void)extractFaultDataFromJsonData:(NSArray *)jsonData
{
    
    [self extractSectionHeaderDataFromFaultDataArray:jsonData];
    [self extractRowDataFromFaultDataArray:jsonData];
}

- (void)extractSectionHeaderDataFromFaultDataArray:(NSArray *)faultData
{
    
    for (NSDictionary *faultDetail in faultData) {
        NSMutableDictionary *headerData = [[NSMutableDictionary alloc] initWithCapacity:1];
        [headerData setObject:[faultDetail valueForKey:@"productGroup"] forKey:@"productGroup"];
        [headerData setObject:[faultDetail valueForKey:@"productImage"] forKey:@"productImage"];
        [_sectionHeaderDataArray addObject:headerData];
    }
    
}

- (void)extractRowDataFromFaultDataArray:(NSArray *)faultData
{
    NSMutableString *recentlySearchedProductName = [[NSMutableString alloc] initWithString:@""];
    for (NSDictionary *faultDetail in faultData) {
        NSMutableArray *cellData = [[NSMutableArray alloc] init];
        int openFaultsCount = [[faultDetail valueForKey:@"openFaults"] count];
        if (openFaultsCount > 0) {
            NSMutableDictionary *subSectionHeaderCell = [[NSMutableDictionary alloc] initWithCapacity:2];
            [subSectionHeaderCell setObject:@"subSectionHeaderCell" forKey:@"cellType"];
            if (openFaultsCount == 1) {
                [subSectionHeaderCell setObject:[NSString stringWithFormat:@"%d Open Fault", openFaultsCount] forKey:@"subSectionHeaderTitle"];
            } else {
                [subSectionHeaderCell setObject:[NSString stringWithFormat:@"%d Open Faults", openFaultsCount] forKey:@"subSectionHeaderTitle"];
            }
            [cellData addObject:subSectionHeaderCell];
            
            for (NSDictionary *openFaultCell in [faultDetail valueForKey:@"openFaults"]) {
                NSLog(@"%@",openFaultCell);
                NSMutableDictionary *openFaultCellData = [[NSMutableDictionary alloc] initWithCapacity:2];
                [openFaultCellData setObject:@"faultDataCell" forKey:@"cellType"];
                
                BTFaultData *faultData = [[BTFaultData alloc] init];
                
                [faultData setFaultReference: [openFaultCell valueForKey:@"faultReference"]];
                [faultData setStatusOnUI: [openFaultCell valueForKey:@"statusOnUI"] ];
                 
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                [faultData setReportedOn:[dateFormatter dateFromString:[openFaultCell valueForKey:@"reportedOn"]]];
                [faultData setProductGroup:[faultDetail valueForKey:@"productGroup"]];
                [faultData setProductImage:[faultDetail valueForKey:@"productImage"]];
                [openFaultCellData setObject:faultData forKey:@"faultData"];
                [cellData addObject:openFaultCellData];
            }
        }
        int closedFaultsCount = [[faultDetail valueForKey:@"closedFaults"] count];
        if (closedFaultsCount > 0) {
            NSMutableDictionary *subSectionHeaderCell = [[NSMutableDictionary alloc] initWithCapacity:2];
            [subSectionHeaderCell setObject:@"subSectionHeaderCell" forKey:@"cellType"];
            if (closedFaultsCount == 1) {
                [subSectionHeaderCell setObject:[NSString stringWithFormat:@"%d Closed Fault", closedFaultsCount] forKey:@"subSectionHeaderTitle"];
            } else {
            [subSectionHeaderCell setObject:[NSString stringWithFormat:@"%d Closed Faults", closedFaultsCount] forKey:@"subSectionHeaderTitle"];
            }
            [cellData addObject:subSectionHeaderCell];
            
            for (NSDictionary *closedFaultCell in [faultDetail valueForKey:@"closedFaults"]) {
                NSMutableDictionary *closedFaultCellData = [[NSMutableDictionary alloc] initWithCapacity:2];
                [closedFaultCellData setObject:@"faultDataCell" forKey:@"cellType"];
                
                BTFaultData *faultData = [[BTFaultData alloc] init];
                
                [faultData setFaultReference:[closedFaultCell valueForKey:@"faultReference"]];
                [faultData setStatusOnUI:[closedFaultCell valueForKey:@"statusOnUI"]];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                [faultData setReportedOn:[dateFormatter dateFromString:[closedFaultCell valueForKey:@"reportedOn"]]];
                [faultData setProductGroup:[faultDetail valueForKey:@"productGroup"]];
                [faultData setProductImage:[faultDetail valueForKey:@"productImage"]];
                [closedFaultCellData setObject:faultData forKey:@"faultData"];
                [cellData addObject:closedFaultCellData];
            }
        }
        [_rowDataForFaultSummaryTableArray addObject:cellData];
        [recentlySearchedProductName appendString:[NSString stringWithFormat:@"%@, ",[faultDetail valueForKey:@"productGroup"]]];
    }
    
    [self.recentlySearchedData setObject:self.serviceIdString forKey:@"serviceId"];
    [self.recentlySearchedData setObject:recentlySearchedProductName forKey:@"productGroupsName"];
    NSDate *current = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm:ss"];
    [self.recentlySearchedData setObject:[dateFormatter stringFromDate:current] forKey:@"lastRecentSearchTime"];
    [self saveRecentlySearchedDataArrayWith:self.recentlySearchedData];
    
}

- (void)saveRecentlySearchedDataArrayWith:(NSDictionary *)searchData
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"recentlySearchedDataArray"]];
    
    for ( NSMutableDictionary *searchedData in dataArray) {
        if ([[searchData valueForKey:@"serviceId"] isEqualToString:[searchedData valueForKey:@"serviceId"]]) {
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
