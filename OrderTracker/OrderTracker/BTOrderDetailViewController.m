//
//  BTOrderDetailViewController.m
//  OrderTracker
//
//  Created by Lakhpat on 11/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTOrderDetailViewController.h"
#import "BTOrderDetailTableViewCell.h"

@interface BTOrderDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *products;
@property (nonatomic) NSArray *productsDetail;

@end

@implementation BTOrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTOrderDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"BTOrderDetailTableViewCell" forIndexPath:indexPath];
    
    
    [detailCell updateCellWithProduct:self.products[indexPath.row] productDetails:self.productsDetail[indexPath.row]];
    
    
    return detailCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BTOrderDetailTableViewCell heightWithProduct:self.products[indexPath.row] productDetails:self.productsDetail[indexPath.row]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _orderDetailHeaderView.frame = CGRectMake(0, -_orderDetailHeaderView.frame.size.height, _orderDetailHeaderView.frame.size.width, _orderDetailHeaderView.frame.size.height);
    _orderDetailTableView.frame = CGRectMake(0, self.view.frame.size.height, _orderDetailTableView.frame.size.width, _orderDetailTableView.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        _orderDetailHeaderView.frame = CGRectMake(0, 0, _orderDetailHeaderView.frame.size.width, _orderDetailHeaderView.frame.size.height);
        _orderDetailTableView.frame = CGRectMake(0, self.view.frame.size.height - _orderDetailTableView.frame.size.height, _orderDetailTableView.frame.size.width, _orderDetailTableView.frame.size.height);
        }
                     completion:nil];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.orderDetailScreenBackgroundImageView.image = [UIImage imageNamed:@"Background.png"];
    
    
    //table data view
    self.orderDetailTableView.delegate = self;
    self.orderDetailTableView.dataSource = self;
    self.orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderDetailTableView.backgroundColor = [UIColor clearColor];
    
    //set Fonts for labels
    self.orderSummaryLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:15];
    self.doneButtonView.titleLabel.font = [UIFont fontWithName:@"NewBT-Regular" size:15];
    self.expectedCompletionNameLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:13];
    self.expectedCompletionLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:16];
    self.orderReferenceIdNameLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:13];
    self.orderReferenceIdLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:16];
    self.orderStatusNameLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:13];
    self.orderStatusLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:16];
    self.orderPlacedNameLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:13];
    self.orderPlacedLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:16];
    
    //hard coded values
    self.expectedCompletionLabelView.text = @"19 FEB 2016";
    self.orderReferenceIdLabelView.text = @"BHDGSF958";
    self.orderStatusLabelView.text = @"COMPLETED";
    self.orderPlacedLabelView.text = @"06 FEB 2016";
    
    //table cell view
    UINib *nib = [UINib nibWithNibName:@"BTOrderDetailTableViewCell" bundle:nil];
    
    [self.orderDetailTableView registerNib:nib forCellReuseIdentifier:@"BTOrderDetailTableViewCell"];
    
    self.products = @[@"BT Business Broadband", @"BT Business Broadband Hardware"];
    self.productsDetail = @[@"Amendment to your BT Business Broadband", @"Amendment to your BT Business Broadband and Connection requirements"];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
