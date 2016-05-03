//
//  BNRAppliance.m
//  BNRAppliance
//
//  Created by Lakhpat on 29/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRAppliance.h"

@implementation BNRAppliance

//@synthesize productName;
@synthesize voltage;

- (instancetype)init
{
    return [self initWithProductName:@"Unknown"];
}

- (instancetype)initWithProductName:(NSString *)pn
{
    self = [super init];
    if(self)
    {
        productName = [pn copy];
        voltage = 120;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %d volts>",productName,self.voltage];
}

@end
