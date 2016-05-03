//
//  BTCustomizeHomeScreenViewController.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 25/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTCustomizeHomeScreenViewController.h"
#import "BTAppFontFamily.h"

@interface BTCustomizeHomeScreenViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *homeScreenItemTableView;
@property (nonatomic, strong) NSMutableArray *visibleHomeScreenItems;
@property (nonatomic, strong) NSMutableArray *notAddedHomeScreenItems;


@end

@implementation BTCustomizeHomeScreenViewController

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
    self.visibleHomeScreenItems = [self loadVisibleHomeScreenItems];
    self.notAddedHomeScreenItems = [self loadNotAddedHomeScreenItems];
    
    NSLog(@"%d",[self.visibleHomeScreenItems count]);
    NSLog(@"%d",[self.notAddedHomeScreenItems count]);
    
    self.homeScreenItemTableView.delegate = self;
    self.homeScreenItemTableView.dataSource = self;
    self.homeScreenItemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.homeScreenItemTableView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1.0f];// colorWithAlphaComponent:0.0f];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[BTAppFontFamily getNewBTBoldFontOfSize:19]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        //NSLog(@"%d",[self.visibleHomeScreenItems count]);
        return [self.visibleHomeScreenItems count];
    } else {
        //NSLog(@"%d",[self.visibleHomeScreenItems count]);
        return [self.notAddedHomeScreenItems count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.section == 0) {
        cell = [self getCellForVisibleItem:indexPath.row];
    } else {
        cell = [self getCellForNotAddedItem:indexPath.row];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 320, 50);
    UILabel *titleHeader = [[UILabel alloc] init];
    
    if (section==0) {
        
        titleHeader.text = @"ITEMS VISIBLE ON HOME SCREEN";
        titleHeader.font = [UIFont systemFontOfSize:13];
        titleHeader.frame = CGRectMake(14, 36, 300, 14);
        titleHeader.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
    } else {
    
        titleHeader.text = @"ITEMS THAT CAN BE ADDED TO HOME SCREEN";
        titleHeader.font = [UIFont systemFontOfSize:13];
        titleHeader.frame = CGRectMake(14, 18, 250, 33);
        titleHeader.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        titleHeader.numberOfLines = 2;
        
    }
    
    [view addSubview:titleHeader];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UITableViewCell *)getCellForVisibleItem:(NSInteger)row
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 225, 17)];
    itemName.text = self.visibleHomeScreenItems[row];
    itemName.font = [BTAppFontFamily getNewBTRegularFontOfSize:17];
    UIButton *removeButton = [[UIButton alloc] init];
    removeButton.frame = CGRectMake(270, 5, 32, 32);
    [removeButton setImage:[UIImage imageNamed:@"SettingsRemoveButton"] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
	removeButton.tag = row;
    [cell addSubview:itemName];
    [cell addSubview:removeButton];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)getCellForNotAddedItem:(NSInteger)row
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 225, 17)];
    itemName.text = self.notAddedHomeScreenItems[row];
    itemName.font = [BTAppFontFamily getNewBTRegularFontOfSize:17];
    UIButton *addButton = [[UIButton alloc] init];
    addButton.frame = CGRectMake(270, 5, 32, 32);
    [addButton setImage:[UIImage imageNamed:@"SettingsAddButton"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = row;
    [cell addSubview:itemName];
    [cell addSubview:addButton];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)removeItem:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    NSString *itemName = self.visibleHomeScreenItems[sender.tag];
    [self.notAddedHomeScreenItems addObject:itemName];
    [self.visibleHomeScreenItems removeObjectAtIndex:sender.tag];
    [self.homeScreenItemTableView reloadData];
}

- (void)addItem:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    NSString *itemName = self.notAddedHomeScreenItems[sender.tag];
    [self.visibleHomeScreenItems addObject:itemName];
    [self.notAddedHomeScreenItems removeObjectAtIndex:sender.tag];
    [self.homeScreenItemTableView reloadData];
}

- (NSMutableArray *)loadVisibleHomeScreenItems
{
    NSMutableArray *visibleData = [[NSMutableArray alloc] init];
    [visibleData addObject:@"Track Order"];
    [visibleData addObject:@"View Bill"];
    [visibleData addObject:@"Track Service ID"];
    [visibleData addObject:@"Need Support"];
    [visibleData addObject:@"My Products"];
    [visibleData addObject:@"Service Diagnostics"];
    [visibleData addObject:@"Check Available Services"];
    return visibleData;
}

- (NSMutableArray *)loadNotAddedHomeScreenItems
{
    NSMutableArray *notAddedData = [[NSMutableArray alloc] init];
    [notAddedData addObject:@"View FAQ's"];
    return notAddedData;
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
