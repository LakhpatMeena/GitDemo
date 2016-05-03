//
//  BTServiceDetailsTableSubSectionViewCellTableViewCell.m
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceDetailsTableSubSectionViewCellTableViewCell.h"
#import "BTAppFontFamily.h"

@implementation BTServiceDetailsTableSubSectionViewCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.subsectionCellTitleLabel.font = [BTAppFontFamily getNewBTBoldFontOfSize:17];
    self.subsectionCellTitleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithTitleLabel:(NSString *)titleString
{
    CGSize maximumSize = CGSizeMake(9999, 9999);
    NSDictionary *attributes = @{NSFontAttributeName: [BTAppFontFamily getNewBTBoldFontOfSize:_subsectionCellTitleLabel.font.pointSize]};
    CGRect rect = [titleString boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    _subsectionCellTitleLabel.frame = CGRectMake(_subsectionCellTitleLabel.frame.origin.x, _subsectionCellTitleLabel.frame.origin.y, rect.size.width, rect.size.height);
    _subsectionCellWhiteDownArrowImageView.frame = CGRectMake(_subsectionCellTitleLabel.frame.origin.x + _subsectionCellTitleLabel.frame.size.width + 5, _subsectionCellWhiteDownArrowImageView.frame.origin.y, _subsectionCellWhiteDownArrowImageView.frame.size.width, _subsectionCellWhiteDownArrowImageView.frame.size.height);
    _subsectionCellTitleLabel.text = titleString;
}

@end
