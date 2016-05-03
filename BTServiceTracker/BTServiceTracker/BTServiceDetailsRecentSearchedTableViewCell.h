//
//  BTServiceDetailsRecentSearchedTableViewCell.h
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTServiceDetailsRecentSearchedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lastRecentSearchTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *productGroupsNameLabel;

-(void)updateCellWithData:(NSDictionary *)cellData;

@end
