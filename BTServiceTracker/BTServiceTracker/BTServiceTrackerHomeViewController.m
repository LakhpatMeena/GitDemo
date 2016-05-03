//
//  BTServiceTrackerHomeViewController.m
//  BTServiceTracker
//
//  Created by Lakhpat on 13/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceTrackerHomeViewController.h"
#import "BTServiceDetailsViewController.h"
#import "BTAppFontFamily.h"
#import "BTServiceDetailsRecentSearchedTableViewCell.h"

#define initialCoordinatesOfBTRoundLogoImageView CGPointMake(117, 50)
#define initialCoordinatesOfServiceIdInputContainerView CGPointMake(4, 85)
#define initialCoordinatesOfRecentlySearchedTableView CGPointMake(0, 295)

@interface BTServiceTrackerHomeViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *BTRoundLogoImageView;
@property (weak, nonatomic) IBOutlet UIView *ServiceIdInputContainerView;
@property (weak, nonatomic) IBOutlet UITextField *ServiceIdInputTextField;
@property (weak, nonatomic) IBOutlet UITableView *recentlySearchedTableView;


@end

@implementation BTServiceTrackerHomeViewController

@synthesize recentlySearchedDataArray;

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
    self.ServiceIdInputTextField.delegate = self;
    self.ServiceIdInputTextField.font = [BTAppFontFamily getNewBTRegularFontOfSize:20];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.recentlySearchedTableView.delegate = self;
    self.recentlySearchedTableView.dataSource = self;
    self.recentlySearchedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recentlySearchedTableView.backgroundColor = [UIColor clearColor];
    
    UINib *dataCell = [UINib nibWithNibName:@"BTServiceDetailsRecentSearchedTableViewCell" bundle:nil];
    
    [self.recentlySearchedTableView registerNib:dataCell forCellReuseIdentifier:@"BTServiceDetailsRecentSearchedTableViewCell"];
    
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.recentlySearchedDataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"recentlySearchedDataArray"]];
    [self.recentlySearchedTableView reloadData];
}

#pragma mark - service id handler

- (IBAction)trackServiceId:(id)sender
{
    [_ServiceIdInputTextField resignFirstResponder];
    [self validateServiceId];
}

- (void)validateServiceId
{
    NSString *serviceId = self.ServiceIdInputTextField.text;
    if ([serviceId isEqualToString:@""] || [serviceId characterAtIndex:0]==' ') {
        NSLog(@"enter valid service id");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Service Id" message:@"Please check and enter valid service id" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [self performSegueWithIdentifier:@"TrackServiceId" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TrackServiceId"]) {
        BTServiceDetailsViewController *svc = segue.destinationViewController;
        svc.serviceIdString = self.ServiceIdInputTextField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationOption = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    CGRect keyboardEndFrame = [self.view convertRect:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
    
    CGFloat yCoordinatesDifferenceOfRoundLogoAndContainerView = initialCoordinatesOfServiceIdInputContainerView.y - initialCoordinatesOfBTRoundLogoImageView.y;
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        
        self.ServiceIdInputContainerView.frame = CGRectMake(initialCoordinatesOfServiceIdInputContainerView.x, keyboardEndFrame.origin.y - self.ServiceIdInputContainerView.frame.size.height - 5, self.ServiceIdInputContainerView.frame.size.width, self.ServiceIdInputContainerView.frame.size.height);
        
        self.BTRoundLogoImageView.frame = CGRectMake(initialCoordinatesOfBTRoundLogoImageView.x, self.ServiceIdInputContainerView.frame.origin.y - yCoordinatesDifferenceOfRoundLogoAndContainerView, self.BTRoundLogoImageView.frame.size.width, self.BTRoundLogoImageView.frame.size.height);
        
        self.recentlySearchedTableView.frame = CGRectMake(initialCoordinatesOfRecentlySearchedTableView.x, self.ServiceIdInputContainerView.frame.origin.y + self.ServiceIdInputContainerView.frame.size.height + 10, self.recentlySearchedTableView.frame.size.width, self.recentlySearchedTableView.frame.size.height);
        
    }completion:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationOption = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        
        self.ServiceIdInputContainerView.frame = CGRectMake(initialCoordinatesOfServiceIdInputContainerView.x, initialCoordinatesOfServiceIdInputContainerView.y, self.ServiceIdInputContainerView.frame.size.width, self.ServiceIdInputContainerView.frame.size.height);
        
        self.BTRoundLogoImageView.frame = CGRectMake(initialCoordinatesOfBTRoundLogoImageView.x, initialCoordinatesOfBTRoundLogoImageView.y, self.BTRoundLogoImageView.frame.size.width, self.BTRoundLogoImageView.frame.size.height);
        
        self.recentlySearchedTableView.frame = CGRectMake(initialCoordinatesOfRecentlySearchedTableView.x, initialCoordinatesOfRecentlySearchedTableView.y, self.recentlySearchedTableView.frame.size.width, self.recentlySearchedTableView.frame.size.height);
        
    }completion:nil];
}

#pragma mark - table View methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.recentlySearchedDataArray count]);
    return [self.recentlySearchedDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTServiceDetailsRecentSearchedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BTServiceDetailsRecentSearchedTableViewCell" forIndexPath:indexPath];
    [cell updateCellWithData:self.recentlySearchedDataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.frame = CGRectMake(0, 2, 320, 15);
    UIButton *headerButton = [[UIButton alloc] init];
    headerButton.frame = CGRectMake(14, 1, 229, 12);
    [headerButton setImage:[UIImage imageNamed:@"TSScreenRecentServiceIDCloseButton"] forState:UIControlStateNormal];
    //headerButton.imageView.image = [UIImage imageNamed:@"TSScreenRecentServiceIDCloseButton"];
    [tableHeaderView addSubview:headerButton];
    //tableHeaderView.backgroundColor = [UIColor whiteColor];
    return tableHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18;
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
