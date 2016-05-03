//
//  BTServiceAvailabilityCheckerViewController.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 20/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceAvailabilityCheckerViewController.h"
#import "BTAppFontFamily.h"
#import "BTServiceAvailabilityDetailsViewController.h"
#import "BTRecentlySearchedPhoneNumberTableViewCell.h"

#define initialCoordinatesOfBTRoundLogoImageView CGPointMake(117, 50)
#define initialCoordinatesOfPhoneNumberInputContainerView CGPointMake(4, 85)
#define initialCoordinatesOfRecentlySearchedTableView CGPointMake(0, 300)

@interface BTServiceAvailabilityCheckerViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *BTRoundLogoImageView;
@property (strong, nonatomic) IBOutlet UIView *phoneNumberInputContainerView;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberInputTextField;
@property (strong, nonatomic) IBOutlet UITableView *recentlySearchedTableView;


@end

@implementation BTServiceAvailabilityCheckerViewController

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
    self.phoneNumberInputTextField.delegate = self;
    self.phoneNumberInputTextField.font = [BTAppFontFamily getNewBTRegularFontOfSize:20];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.recentlySearchedTableView.delegate = self;
    self.recentlySearchedTableView.dataSource = self;
    self.recentlySearchedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recentlySearchedTableView.backgroundColor = [UIColor clearColor];
    
    UINib *dataCell = [UINib nibWithNibName:@"BTRecentlySearchedPhoneNumberTableViewCell" bundle:nil];
    
    [self.recentlySearchedTableView registerNib:dataCell forCellReuseIdentifier:@"BTRecentlySearchedPhoneNumberTableViewCell"];
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

- (IBAction)trackAvailableService:(id)sender
{
    [_phoneNumberInputTextField resignFirstResponder];
    [self validatePhoneNumber];
}

- (void)validatePhoneNumber
{
    NSString *phoneNumber = self.phoneNumberInputTextField.text;
    if ([phoneNumber isEqualToString:@""] || [phoneNumber characterAtIndex:0]==' ') {
        NSLog(@"enter valid service id");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Service Id" message:@"Please check and enter valid service id" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [self performSegueWithIdentifier:@"CheckAvailableService" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CheckAvailableService"]) {
        //BTServiceAvailabilityDetailsViewController *svc = segue.destinationViewController;
        //svc.serviceIdString = self.ServiceIdInputTextField.text;
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
    
    CGFloat yCoordinatesDifferenceOfRoundLogoAndContainerView = initialCoordinatesOfPhoneNumberInputContainerView.y - initialCoordinatesOfBTRoundLogoImageView.y;
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        
        self.phoneNumberInputContainerView.frame = CGRectMake(initialCoordinatesOfPhoneNumberInputContainerView.x, keyboardEndFrame.origin.y - self.phoneNumberInputContainerView.frame.size.height - 5, self.phoneNumberInputContainerView.frame.size.width, self.phoneNumberInputContainerView.frame.size.height);
        
        self.BTRoundLogoImageView.frame = CGRectMake(initialCoordinatesOfBTRoundLogoImageView.x, self.phoneNumberInputContainerView.frame.origin.y - yCoordinatesDifferenceOfRoundLogoAndContainerView, self.BTRoundLogoImageView.frame.size.width, self.BTRoundLogoImageView.frame.size.height);
        
        self.recentlySearchedTableView.frame = CGRectMake(initialCoordinatesOfRecentlySearchedTableView.x, self.phoneNumberInputContainerView.frame.origin.y + self.phoneNumberInputContainerView.frame.size.height + 5, self.recentlySearchedTableView.frame.size.width, self.recentlySearchedTableView.frame.size.height);
        
    }completion:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions animationOption = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        
        self.phoneNumberInputContainerView.frame = CGRectMake(initialCoordinatesOfPhoneNumberInputContainerView.x, initialCoordinatesOfPhoneNumberInputContainerView.y, self.phoneNumberInputContainerView.frame.size.width, self.phoneNumberInputContainerView.frame.size.height);
        
        self.BTRoundLogoImageView.frame = CGRectMake(initialCoordinatesOfBTRoundLogoImageView.x, initialCoordinatesOfBTRoundLogoImageView.y, self.BTRoundLogoImageView.frame.size.width, self.BTRoundLogoImageView.frame.size.height);
        
        self.recentlySearchedTableView.frame = CGRectMake(initialCoordinatesOfRecentlySearchedTableView.x, initialCoordinatesOfRecentlySearchedTableView.y, self.recentlySearchedTableView.frame.size.width, self.recentlySearchedTableView.frame.size.height);
        
    }completion:nil];
}

#pragma mark - table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.recentlySearchedDataArray count]);
    return [self.recentlySearchedDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTRecentlySearchedPhoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BTRecentlySearchedPhoneNumberTableViewCell" forIndexPath:indexPath];
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
    headerButton.frame = CGRectMake(14, 0, 229, 12);
    [headerButton setImage:[UIImage imageNamed:@"CASScreenRecentPhoneNumberCloseButton"] forState:UIControlStateNormal];
    //headerButton.imageView.image = [UIImage imageNamed:@"TSScreenRecentServiceIDCloseButton"];
    [tableHeaderView addSubview:headerButton];
    //tableHeaderView.backgroundColor = [UIColor whiteColor];
    return tableHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"CheckAvailableService" sender:nil];
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
