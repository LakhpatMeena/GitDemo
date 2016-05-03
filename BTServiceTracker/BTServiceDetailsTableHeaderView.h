//
//  BTServiceDetailsTableHeaderView.h
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTServiceDetailsTableHeaderView : UIView

@property (nonatomic, strong) UIImageView *headerBackgroundImageView;
@property (nonatomic, strong) UIImageView *productIconImageView;
@property (nonatomic, strong) UILabel *productGroupNameLabel;

- (void)updateHeaderViewWithFaultData:(NSDictionary *)headerData;

@end
