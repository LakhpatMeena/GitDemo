//
//  BTOrderDetailViewController.h
//  OrderTracker
//
//  Created by Lakhpat on 11/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTOrderDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *orderDetailScreenBackgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *orderDetailHeaderView;
@property (strong, nonatomic) IBOutlet UILabel *orderSummaryLabelView;
@property (strong, nonatomic) IBOutlet UIButton *doneButtonView;
@property (strong, nonatomic) IBOutlet UILabel *expectedCompletionLabelView;
@property (strong, nonatomic) IBOutlet UILabel *orderReferenceIdLabelView;
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLabelView;
@property (strong, nonatomic) IBOutlet UILabel *orderPlacedLabelView;
@property (strong, nonatomic) IBOutlet UITableView *orderDetailTableView;
@property (strong, nonatomic) IBOutlet UILabel *orderReferenceIdNameLabelView;
@property (strong, nonatomic) IBOutlet UILabel *expectedCompletionNameLabelView;
@property (strong, nonatomic) IBOutlet UILabel *orderStatusNameLabelView;
@property (strong, nonatomic) IBOutlet UILabel *orderPlacedNameLabelView;



@end
