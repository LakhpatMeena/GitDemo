//
//  BTAvailableServiceData.m
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 21/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTAvailableServiceData.h"

@implementation BTAvailableServiceData

@synthesize serviceName;
@synthesize serviceCharge;
@synthesize highDownSpeed;
@synthesize highUpSpeed;
@synthesize lowDownSpeed;
@synthesize lowUpSpeed;
@synthesize usage;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@",serviceName,serviceCharge,highDownSpeed,highUpSpeed,lowDownSpeed,lowUpSpeed,usage];
}

@end
