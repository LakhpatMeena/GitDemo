//
//  BTServiceDetailsTableViewCell.m
//  BTServiceTracker
//
//  Created by Lakhpat on 14/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceDetailsTableViewCell.h"
#import "BTAppFontFamily.h"

@implementation BTServiceDetailsTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.faultReferenceTitleLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:10];
    self.statusTitleLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:10];
    self.reportedOnTitleLabel.font = [BTAppFontFamily getNewBTRegularFontOfSize:10];
    
    self.faultReferenceLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:12];
    self.statusLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:12];
    self.reportedOnLabel.font = [BTAppFontFamily getBTFontExtraBoldFontOfSize:12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
