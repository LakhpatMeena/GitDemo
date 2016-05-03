//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Lakhpat on 01/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UISegmentedControl *colorControl;
@property (nonatomic, weak) UITextField *textField;

@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.tabBarItem.title = @"Hypnotize";
        UIImage *h = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = h;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.colorControl addTarget:self.view action:@selector(selectCircleColor:) forControlEvents:UIControlEventValueChanged];
    
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect frame = CGRectMake(40, 70, 240, 30);
        self.textField.frame = frame;
    } completion:NULL];
    
}


- (void)loadView
{
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    //CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    //UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    UITextField *textField = [[UITextField alloc] init];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    
    self.textField = textField;
    self.view = backgroundView;
    
    /*self.colorControl = [[UISegmentedControl alloc] initWithItems:@[@"Red", @"Green", @"Blue"]];
    
    self.colorControl.frame = CGRectMake(self.view.bounds.origin.x+40, self.view.bounds.origin.y+350, 200, 30);
    self.colorControl.tintColor = [UIColor blackColor];
    [self.view addSubview:self.colorControl];*/
    
    
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i=0; i<20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;
        
        //size relative to text
        [messageLabel sizeToFit];
        
        int width=(int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random()%width;
        
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random()%height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        messageLabel.alpha = 0.0;
        //[UIView animateWithDuration:0.5 animations:^{
          //  messageLabel.alpha = 1.0;
        //}];
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            messageLabel.alpha = 1.0;
        } completion:NULL];
        
        [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
                messageLabel.center = self.view.center;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                int x = arc4random()%width;
                int y = arc4random()%height;
                messageLabel.center = CGPointMake(x, y);
            }];
            
        } completion:NULL];
        
        //motion effects for tilt and all
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
//        motionEffect.minimumRelativeValue = @(-25);
//        motionEffect.maximumRelativeValue = @(25);
//        [messageLabel addMotionEffect:motionEffect];
//        
//        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
//        motionEffect.minimumRelativeValue = @(-25);
//        motionEffect.maximumRelativeValue = @(25);
//        [messageLabel addMotionEffect:motionEffect];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}
@end
