//
//  BTRecentlySearchedPhoneNumberTableViewCell.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 22/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTRecentlySearchedPhoneNumberTableViewCell.h"

@implementation BTRecentlySearchedPhoneNumberTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithData:(NSDictionary *)cellData
{
    _phoneNumberLabel.text = [cellData valueForKey:@"phoneNumber"];
    _lastSearchedTimeLabel.text = [NSString stringWithFormat:@"last Searched On %@",[cellData valueForKey:@"lastSearchedTime"]];
    _availabilityInfoLabel.text = [NSString stringWithFormat:@"%@ plans are available on this number", [cellData valueForKey:@"availabilityInfo"]];
    
}

@end
