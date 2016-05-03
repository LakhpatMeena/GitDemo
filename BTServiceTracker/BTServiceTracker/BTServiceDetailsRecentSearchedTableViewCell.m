//
//  BTServiceDetailsRecentSearchedTableViewCell.m
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceDetailsRecentSearchedTableViewCell.h"

@implementation BTServiceDetailsRecentSearchedTableViewCell

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
    _serviceIdLabel.text = [cellData valueForKey:@"serviceId"];
    _lastRecentSearchTimeLabel.text = [NSString stringWithFormat:@"last Searched On %@",[cellData valueForKey:@"lastRecentSearchTime"]];
    _productGroupsNameLabel.text = [cellData valueForKey:@"productGroupsName"];
}

@end
