//
//  BTServiceAvailabilityDetailsTableViewCell.h
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 20/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTAvailableServiceData.h"

@interface BTServiceAvailabilityDetailsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *availableServicesMeterBackgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *availableServicesMeterNeedleImageView;
@property (strong, nonatomic) IBOutlet UIImageView *availableServicesCellDividerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *firstDetailsDividerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondDetailsDividerImageView;
@property (strong, nonatomic) IBOutlet UILabel *availableServiceNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *availableServiceChargeLabel;
@property (strong, nonatomic) IBOutlet UILabel *downloadSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploadSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *usageLabel;
@property (strong, nonatomic) IBOutlet UILabel *usageValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *uploadSpeedValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *downloadSpeedValueLabel;

- (void)updateCellWithServiceData:(BTAvailableServiceData *)serviceData withCellDivider:(BOOL)isVisible;

@end
