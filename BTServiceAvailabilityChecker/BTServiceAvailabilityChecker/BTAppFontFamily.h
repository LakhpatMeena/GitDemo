//
//  BTAppFontFamily.h
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTAppFontFamily : NSObject

+(UIFont *)getNewBTBoldFontOfSize:(CGFloat)fontSize;
+(UIFont *)getNewBTRegularFontOfSize:(CGFloat)fontSize;
+(UIFont *)getBTFontLightFontOfSize:(CGFloat)fontSize;
+(UIFont *)getBTFontExtraBoldFontOfSize:(CGFloat)fontSize;


@end
