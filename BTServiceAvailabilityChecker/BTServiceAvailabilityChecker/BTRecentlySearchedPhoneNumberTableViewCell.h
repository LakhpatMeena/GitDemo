//
//  BTRecentlySearchedPhoneNumberTableViewCell.h
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 22/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTRecentlySearchedPhoneNumberTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lastSearchedTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *availabilityInfoLabel;

-(void)updateCellWithData:(NSDictionary *)cellData;

@end
