//
//  BNRColorDiscription.m
//  ColorBoard
//
//  Created by Lakhpat on 02/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BNRColorDiscription.h"

@implementation BNRColorDiscription

- (instancetype)init
{
    self = [super init];
    if (self) {
        _color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1.0];
        _name = @"Blue";
    }
    return self;
}

@end
