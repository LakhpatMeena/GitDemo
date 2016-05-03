//
//  BNRItemCell.h
//  Homepwner
//
//  Created by Lakhpat on 05/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItemCell : UITableViewCell
@property (nonatomic) IBOutlet UIImageView *itemImageView;
@property (nonatomic) IBOutlet UILabel *itemNameLabel;
@property (nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
