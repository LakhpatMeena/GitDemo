//
//  BTHomeScreenViewController.m
//  OrderTracker
//
//  Created by Lakhpat on 05/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTHomeScreenViewController.h"
#import "BTOrderDetailViewController.h"

@interface BTHomeScreenViewController ()<UITextFieldDelegate>

@property (nonatomic) UIImageView *circularLogo;
@property (nonatomic) UIImageView *orderReferenceImage;
@property (nonatomic) UITextField *orderReferenceField;
@property (nonatomic) UIImageView *homeBackground;
@property (nonatomic) UIButton *orderTracker;

@end

@implementation BTHomeScreenViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationController.navigationBarHidden = YES;
    
    //background image for home screen
    self.homeBackground = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.homeBackground.image = [UIImage imageNamed:@"Background.png"];
    
    //screen to enter order id
    self.orderReferenceImage = [[UIImageView alloc] init];
    self.orderReferenceImage.frame = CGRectMake(5, 109, 311, 192);
    self.orderReferenceImage.image = [UIImage imageNamed:@"HomeScreenEnterOrderIDBackground.png"];
    
    //BT logo
    self.circularLogo = [[UIImageView alloc] init];
    self.circularLogo.frame = CGRectMake(117, 68, 88, 88);
    self.circularLogo.image = [UIImage imageNamed:@"BritishTelecomLogoRound.png"];
    
    //textfield to take order id
    self.orderReferenceField = [[UITextField alloc] init];
    self.orderReferenceField.frame = CGRectMake(187, 190, 113, 30);
    self.orderReferenceField.keyboardType = UIKeyboardAppearanceDefault;
    self.orderReferenceField.returnKeyType = UIReturnKeyDone;
    self.orderReferenceField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.orderReferenceField.placeholder = @"Tap here";
    self.orderReferenceField.font = [UIFont fontWithName:@"NewBT-Regular" size:20];
    self.orderReferenceField.delegate = self;

    //track order button
    self.orderTracker = [[UIButton alloc] init];
    self.orderTracker.frame = CGRectMake(46, 238, 229, 44);
    [self.orderTracker setBackgroundImage:[UIImage imageNamed:@"HomeScreenTrackOrderButton.png"] forState:UIControlStateNormal];
    [self.orderTracker addTarget:self action:@selector(trackOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.homeBackground];
    [self.view addSubview:self.orderReferenceImage];
    [self.view addSubview:self.circularLogo];
    [self.view addSubview:self.orderReferenceField];
    [self.view addSubview:self.orderTracker];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)trackOrder:(UIButton *)sender {
    NSString *orderId = self.orderReferenceField.text;
    NSLog(@"%@ : %d",orderId,[orderId length]);
    if ([orderId isEqualToString:@""] || [orderId characterAtIndex:0]==' ') {
        NSLog(@"enter valid order reference");
        UIAlertView *invalidOrderId = [[UIAlertView alloc] initWithTitle:@"Invalid Order Reference" message:@"Please check and enter valid order reference" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [invalidOrderId show];
    }
    else{
        
        NSLog(@"go with order reference");
        BTOrderDetailViewController *odvc = [[BTOrderDetailViewController alloc] initWithNibName:@"BTOrderDetailViewController" bundle:nil];
        [self.navigationController pushViewController:odvc animated:YES];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
