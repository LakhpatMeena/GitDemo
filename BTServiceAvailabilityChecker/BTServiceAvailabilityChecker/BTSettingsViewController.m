//
//  BTSettingsViewController.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 24/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTSettingsViewController.h"
#import "BTAppFontFamily.h"

@interface BTSettingsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingsTableView;
@property (strong, nonatomic) NSArray *settingsArray;

@end

@implementation BTSettingsViewController

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
    
    
    self.settingsArray = [self loadSettingsArray];
    
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[BTAppFontFamily getNewBTBoldFontOfSize:19]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = self.settingsArray[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if ([[cellData objectForKey:@"type"] isEqualToString:@"toggle"]) {
        cell = [self cellForToggleTypeItemWith:cellData];
    } else {
        cell = [self cellForButtonTypeItemWith:cellData];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"%@, %d",self.settingsArray, indexPath.row);
    //NSDictionary *cellData = self.settingsArray[indexPath.row];
    //NSLog(@"%@",cellData);
    //NSLog(@"%@",[self.settingsArray[indexPath.row] valueForKey:@"settingName"]);
    if ([[self.settingsArray[indexPath.row] objectForKey:@"settingName"] isEqualToString:@"Customize Home Screen"]) {
        NSLog(@"perform segue");
        [self performSegueWithIdentifier:@"ConfigureHomeScreen" sender:nil];
    }
}

- (UITableViewCell *)cellForToggleTypeItemWith:(NSDictionary *)cellData
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UILabel *settingName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 225, 18)];
    settingName.text = [cellData objectForKey:@"settingName"];
    settingName.font = [BTAppFontFamily getNewBTRegularFontOfSize:17];
    UISwitch *toggleSetting = [[UISwitch alloc] init];
    toggleSetting.frame = CGRectMake(260, 5, toggleSetting.frame.size.width, toggleSetting.frame.size.height);
    [toggleSetting setOn:YES];
    [cell addSubview:settingName];
    [cell addSubview:toggleSetting];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)cellForButtonTypeItemWith:(NSDictionary *)cellData
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UILabel *settingName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 225, 18)];
    settingName.text = [cellData objectForKey:@"settingName"];
    settingName.font = [BTAppFontFamily getNewBTRegularFontOfSize:17];
    [cell addSubview:settingName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSArray *)loadSettingsArray
{
    NSMutableArray *settingsDataArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *ordersNotify = [[NSMutableDictionary alloc] init];
    [ordersNotify setObject:@"Push notifications for Orders" forKey:@"settingName"];
    [ordersNotify setObject:@"toggle" forKey:@"type"];
    [ordersNotify setObject:@"yes" forKey:@"toggleValue"];
    [settingsDataArray addObject:ordersNotify];
    
    NSMutableDictionary *faultsNotify = [[NSMutableDictionary alloc] init];
    [faultsNotify setObject:@"Push notifications for Faults" forKey:@"settingName"];
    [faultsNotify setObject:@"toggle" forKey:@"type"];
    [faultsNotify setObject:@"yes" forKey:@"toggleValue"];
    [settingsDataArray addObject:faultsNotify];
    
    NSMutableDictionary *customize = [[NSMutableDictionary alloc] init];
    [customize setObject:@"Customize Home Screen" forKey:@"settingName"];
    [customize setObject:@"button" forKey:@"type"];
    [settingsDataArray addObject:customize];
    
    return settingsDataArray;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ConfigureHomeScreen"]) {
        //BTServiceAvailabilityDetailsViewController *svc = segue.destinationViewController;
        //svc.serviceIdString = self.ServiceIdInputTextField.text;
    }
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
