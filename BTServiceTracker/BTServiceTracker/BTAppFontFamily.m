//
//  BTAppFontFamily.m
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTAppFontFamily.h"

@implementation BTAppFontFamily

+ (UIFont *)getNewBTRegularFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"NewBT-Regular" size:fontSize];
}

+ (UIFont *)getNewBTBoldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"NewBT-Bold" size:fontSize];
}

+(UIFont *)getBTFontLightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"BTFont-Light" size:fontSize];
}

+(UIFont *)getBTFontExtraBoldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"BTFont-ExtraBold" size:fontSize];
}

@end
