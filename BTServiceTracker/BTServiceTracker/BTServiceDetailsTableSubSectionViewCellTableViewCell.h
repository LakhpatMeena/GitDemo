//
//  BTServiceDetailsTableSubSectionViewCellTableViewCell.h
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTServiceDetailsTableSubSectionViewCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subsectionCellTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subsectionCellWhiteDownArrowImageView;

- (void)updateCellWithTitleLabel:(NSString *)titleString;

@end
