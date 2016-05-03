//
//  BTOrderDetailTableViewCell.h
//  OrderTracker
//
//  Created by Lakhpat on 11/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTOrderDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *productNameLabelView;
@property (strong, nonatomic) IBOutlet UILabel *productDetailLabelView;
@property (strong, nonatomic) IBOutlet UIImageView *productIconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *cellHeaderImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *orderProgressBarView;
@property (strong, nonatomic) IBOutlet UIImageView *rightBottomCornerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *cellFooterImageView;
@property (strong, nonatomic) IBOutlet UIImageView *cellBackgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *progressStatusLabelView;
@property (strong, nonatomic) IBOutlet UIImageView *progressBarDotImageView;
@property (strong, nonatomic) IBOutlet UILabel *orderProgressLabelView;
@property (strong, nonatomic) IBOutlet UILabel *estimatedCompletionLabelView;
@property (strong, nonatomic) IBOutlet UILabel *estimatedCompletionDateLabelView;
@property (strong, nonatomic) IBOutlet UILabel *oneOffLabelView;
@property (strong, nonatomic) IBOutlet UILabel *oneOffValueLabelView;
@property (strong, nonatomic) IBOutlet UILabel *regularLabelView;
@property (strong, nonatomic) IBOutlet UILabel *regularValueLabelView;

- (void)updateCellWithProduct:(NSString *)productName productDetails:(NSString *)productDetail;

+ (CGFloat)heightWithProduct:(NSString *)productName productDetails:(NSString *)productDetail;

@end

