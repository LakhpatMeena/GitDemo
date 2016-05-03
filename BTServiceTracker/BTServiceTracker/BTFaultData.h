//
//  BTFaultData.h
//  BTServiceTracker
//
//  Created by Lakhpat on 19/04/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTFaultData : NSObject

@property (nonatomic, strong) NSString *faultReference;
@property (nonatomic, strong) NSString *statusOnUI;
@property (nonatomic, strong) NSDate *reportedOn;
@property (nonatomic, strong) NSString *productGroup;
@property (nonatomic, strong) NSString *productImage;

@end
