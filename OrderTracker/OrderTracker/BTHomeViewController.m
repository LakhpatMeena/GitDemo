//
//  BTHomeViewController.m
//  OrderTracker
//
//  Created by Lakhpat on 05/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTHomeViewController.h"

@interface BTHomeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *circularLogo;
@property (weak, nonatomic) IBOutlet UIImageView *orderReferenceImage;
@property (weak, nonatomic) IBOutlet UITextField *orderReferenceField;
@property (weak, nonatomic) IBOutlet UIImageView *homeBackground;
@property (weak, nonatomic) IBOutlet UIButton *orderTracker;

@end

@implementation BTHomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.homeBackground.image = [UIImage imageNamed:@"Background.png"];
    self.orderReferenceImage.image = [UIImage imageNamed:@"HomeScreenEnterOrderIDBackground.png"];
    self.circularLogo.image = [UIImage imageNamed:@"BritishTelecomLogoRound.png"];
    [self.orderTracker setBackgroundImage:[UIImage imageNamed:@"HomeScreenTrackOrderButton.png"] forState:UIControlStateNormal];
    self.orderReferenceField.returnKeyType = UIReturnKeyDone;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)trackOrder:(id)sender {
    NSString *orderReference = self.orderReferenceField.text;
    if (orderReference) {
        NSLog(@"go with order reference");
    }
    else{
        NSLog(@"enter order reference");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
