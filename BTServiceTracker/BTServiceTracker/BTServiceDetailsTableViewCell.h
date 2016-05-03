//
//  BTServiceDetailsTableViewCell.h
//  BTServiceTracker
//
//  Created by Lakhpat on 14/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTServiceDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *faultReferenceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportedOnTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *faultReferenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportedOnLabel;


@end
