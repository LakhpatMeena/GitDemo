//
//  BTServiceDetailsTableHeaderView.m
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTServiceDetailsTableHeaderView.h"
#import "BTAppFontFamily.h"

@implementation BTServiceDetailsTableHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, 320, 50);
        self.backgroundColor = [UIColor clearColor];
        _headerBackgroundImageView = [[UIImageView alloc] init];
        _productIconImageView = [[UIImageView alloc] init];
        _productGroupNameLabel = [[UILabel alloc] init];
        _productGroupNameLabel.font = [BTAppFontFamily getNewBTBoldFontOfSize:20];
        _productGroupNameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    _headerBackgroundImageView.frame = CGRectMake(18, 2, 282, 43);
    _headerBackgroundImageView.image = [UIImage imageNamed:@"FaultSummaryScreenSectionHeaderBG"];
    [self addSubview:_headerBackgroundImageView];
    
    _productIconImageView.frame = CGRectMake(25, 6, 42, 35);
    [self addSubview:_productIconImageView];
    
    _productGroupNameLabel.frame = CGRectMake(75, 12, 200, 23);
    [self addSubview:_productGroupNameLabel];
    
}

- (void)updateHeaderViewWithFaultData:(NSDictionary *)headerData
{
    _productIconImageView.image = [UIImage imageNamed:[self getImageWithProductName:[headerData valueForKey:@"productImage"]]];
    _productGroupNameLabel.text = [headerData valueForKey:@"productGroup"];
}

- (NSString *)getImageWithProductName:(NSString *)nameString
{
    NSString *imageName = nil;
    
    if ([nameString isEqualToString:@"#icon-telephone"]) {
        imageName = @"ProductIcon_Telephone";
    } else if ([nameString isEqualToString:@"#icon-broadband-hub"]) {
        imageName = @"ProductIcon_Hub";
    } else if ([nameString isEqualToString:@"#icon-isdn"]) {
        imageName = @"ProductIcon_ISDN30";
    } else if ([nameString isEqualToString:@"#icon-email"]) {
        imageName = @"ProductIcon_Bundle";
    }
    
    return imageName;
}

@end
