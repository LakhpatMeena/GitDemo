//
//  BTOrderDetailTableViewCell.m
//  OrderTracker
//
//  Created by Lakhpat on 11/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTOrderDetailTableViewCell.h"

@interface BTOrderDetailTableViewCell ()

+ (CGFloat)getLabelHeightForText:(NSString *)text Width:(CGFloat)labelWidth fontSize:(CGFloat)fontSize;

@end

@implementation BTOrderDetailTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _productNameLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:16];
    _productDetailLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:12];
    _orderProgressLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:10];
    _progressStatusLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:9];
    _estimatedCompletionLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:11];
    _estimatedCompletionDateLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:10];
    _oneOffLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:9];
    _oneOffValueLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:10];
    _regularLabelView.font = [UIFont fontWithName:@"NewBT-Regular" size:9];
    _regularValueLabelView.font = [UIFont fontWithName:@"NewBT-Bold" size:10];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cellHeaderImageView.image = [UIImage imageNamed:@"OrderSummaryTableViewCellBackgroundTop.png"];
    _cellFooterImageView.image = [UIImage imageNamed:@"OrderSummaryTableViewCellBackgroundBottom.png"];
    _cellBackgroundImageView.image = [UIImage imageNamed:@"OrderSummaryTableViewCellBackgroundCenter.png"];
    _productIconImageView.image = [UIImage imageNamed:@"ProductIcon_Hub.png"];
    _rightBottomCornerImageView.image = [UIImage imageNamed:@"OrderSummaryTableViewCellArrowWithPurpleBackground.png"];
    _progressBarDotImageView.image = [UIImage imageNamed:@"OrderSummaryTableViewCellProgressCircle.png"];
    _estimatedCompletionDateLabelView.text = @"22 FEB 2016";
    _oneOffValueLabelView.text = @"£0.00";
    _regularValueLabelView.text = @"£34.00";
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithProduct:(NSString *)productName productDetails:(NSString *)productDetail
{
    _productNameLabelView.text = productName;
    _productNameLabelView.numberOfLines = 0;
    
    _productDetailLabelView.text = productDetail;
    
    _productDetailLabelView.numberOfLines = 0;
    
    _orderProgressBarView.progress = 100;
    
    
    CGFloat productNameLabelHeight = [BTOrderDetailTableViewCell getLabelHeightForText:self.productNameLabelView.text Width:self.productNameLabelView.frame.size.width fontSize:self.productNameLabelView.font.pointSize];
    
    //NSLog(@"%f",productNameLabelHeight);
    CGFloat diff1 = productNameLabelHeight - _productNameLabelView.frame.size.height;
    //NSLog(@"%f",diff1);
    
    _productDetailLabelView.numberOfLines = 0;
    CGFloat productDetailLabelHeight = [BTOrderDetailTableViewCell getLabelHeightForText:self.productDetailLabelView.text Width:self.productDetailLabelView.frame.size.width fontSize:self.productDetailLabelView.font.pointSize];
    
    //NSLog(@"%f",productDetailLabelHeight);
    CGFloat diff2 = productDetailLabelHeight - _productDetailLabelView.frame.size.height;
    NSLog(@"%f",diff2);
    
    diff2 += diff1;
    
    //change subviews according to difference
    _productNameLabelView.frame = CGRectMake(_productNameLabelView.frame.origin.x, _productNameLabelView.frame.origin.y, _productNameLabelView.frame.size.width, productNameLabelHeight);
    _productDetailLabelView.frame = CGRectMake(_productDetailLabelView.frame.origin.x, _productDetailLabelView.frame.origin.y+diff1, _productDetailLabelView.frame.size.width, productDetailLabelHeight);
    _productDetailLabelView.frame = CGRectMake(_productDetailLabelView.frame.origin.x, _productDetailLabelView.frame.origin.y, _productDetailLabelView.frame.size.width, productDetailLabelHeight);
    _productIconImageView.frame = CGRectMake(_productIconImageView.frame.origin.x, _productIconImageView.frame.origin.y+diff2, _productIconImageView.frame.size.width, _productIconImageView.frame.size.height);
    _orderProgressLabelView.frame = CGRectMake(_orderProgressLabelView.frame.origin.x, _orderProgressLabelView.frame.origin.y+diff2, _orderProgressLabelView.frame.size.width, _orderProgressLabelView.frame.size.height);
    _orderProgressBarView.frame = CGRectMake(_orderProgressBarView.frame.origin.x, _orderProgressBarView.frame.origin.y+diff2, _orderProgressBarView.frame.size.width, _orderProgressBarView.frame.size.height);
    _estimatedCompletionLabelView.frame = CGRectMake(_estimatedCompletionLabelView.frame.origin.x, _estimatedCompletionLabelView.frame.origin.y+diff2, _estimatedCompletionLabelView.frame.size.width, _estimatedCompletionLabelView.frame.size.height);
    _estimatedCompletionDateLabelView.frame = CGRectMake(_estimatedCompletionDateLabelView.frame.origin.x, _estimatedCompletionDateLabelView.frame.origin.y+diff2, _estimatedCompletionDateLabelView.frame.size.width, _estimatedCompletionDateLabelView.frame.size.height);
    _oneOffLabelView.frame = CGRectMake(_oneOffLabelView.frame.origin.x, _oneOffLabelView.frame.origin.y+diff2, _oneOffLabelView.frame.size.width, _oneOffLabelView.frame.size.height);
    _oneOffValueLabelView.frame = CGRectMake(_oneOffValueLabelView.frame.origin.x, _oneOffValueLabelView.frame.origin.y+diff2, _oneOffValueLabelView.frame.size.width, _oneOffValueLabelView.frame.size.height);
    _regularLabelView.frame = CGRectMake(_regularLabelView.frame.origin.x, _regularLabelView.frame.origin.y+diff2, _regularLabelView.frame.size.width, _regularLabelView.frame.size.height);
    _regularValueLabelView.frame = CGRectMake(_regularValueLabelView.frame.origin.x, _regularValueLabelView.frame.origin.y+diff2, _regularValueLabelView.frame.size.width, _regularValueLabelView.frame.size.height);
    _rightBottomCornerImageView.frame = CGRectMake(_rightBottomCornerImageView.frame.origin.x, _rightBottomCornerImageView.frame.origin.y+diff2, _rightBottomCornerImageView.frame.size.width, _rightBottomCornerImageView.frame.size.height);
    _cellFooterImageView.frame = CGRectMake(_cellFooterImageView.frame.origin.x, _cellFooterImageView.frame.origin.y+diff2, _cellFooterImageView.frame.size.width, _cellFooterImageView.frame.size.height);
    _cellBackgroundImageView.frame = CGRectMake(_cellBackgroundImageView.frame.origin.x, _cellBackgroundImageView.frame.origin.y, _cellBackgroundImageView.frame.size.width, _cellBackgroundImageView.frame.size.height+diff2);
    
    
    [_orderProgressBarView setTransform:CGAffineTransformMakeScale(1.0,2.0)];
    _orderProgressBarView.layer.cornerRadius = 2.0;
    _orderProgressBarView.clipsToBounds = YES;
    
    //deal with progress status
    if ( [_progressStatusLabelView.text isEqualToString:@"Completion"])
    {
        
        _progressBarDotImageView.frame = CGRectMake(_progressBarDotImageView.frame.origin.x, _progressBarDotImageView.frame.origin.y+diff2, _progressBarDotImageView.frame.size.width, _progressBarDotImageView.frame.size.height);
        
        _progressStatusLabelView.frame = CGRectMake(_progressStatusLabelView.frame.origin.x, _progressStatusLabelView.frame.origin.y+diff2, _progressStatusLabelView.frame.size.width, _progressStatusLabelView.frame.size.height);
    }
    else
    {
        
        _progressBarDotImageView.frame = CGRectMake(_orderProgressBarView.frame.origin.x, _progressBarDotImageView.frame.origin.y+diff2, _progressBarDotImageView.frame.size.width, _progressBarDotImageView.frame.size.height);
        
        
        
        _progressStatusLabelView.frame = CGRectMake(_orderProgressBarView.frame.origin.x, _progressStatusLabelView.frame.origin.y+diff2, _progressStatusLabelView.frame.size.width, _progressStatusLabelView.frame.size.height);
    }
}

+ (CGFloat)heightWithProduct:(NSString *)productName productDetails:(NSString *)productDetail
{
    CGFloat productNameLabelHeight = [self getLabelHeightForText:productName Width:178 fontSize:16];
    
    CGFloat productDetailLabelHeight = [self getLabelHeightForText:productDetail Width:178 fontSize:12];
    
    return 140+productNameLabelHeight+productDetailLabelHeight;
}

+ (CGFloat)getLabelHeightForText:(NSString *)text Width:(CGFloat)labelWidth fontSize:(CGFloat)fontSize
{
    CGSize maximumSize = CGSizeMake(labelWidth, 10000);
    //NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"NewBT-Bold" size:fontSize]};
    CGRect rect = [text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //CGSize labelTextSize = [text sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:maximumSize lineBreakMode:UILineBreakModeTailTruncation];
    return rect.size.height;
}


@end
