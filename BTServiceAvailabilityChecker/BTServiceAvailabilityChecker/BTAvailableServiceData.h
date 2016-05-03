//
//  BTAvailableServiceData.h
//  BTServiceAvailabilityChecker
//
//  Created by Lakhpat on 21/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTAvailableServiceData : NSObject

@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *serviceCharge;
@property (nonatomic, strong) NSString *highDownSpeed;
@property (nonatomic, strong) NSString *highUpSpeed;
@property (nonatomic, strong) NSString *lowDownSpeed;
@property (nonatomic, strong) NSString *lowUpSpeed;
@property (nonatomic, strong) NSString *usage;

@end
