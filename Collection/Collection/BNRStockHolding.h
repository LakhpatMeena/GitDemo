//
//  BNRStockHolding.h
//  Collection
//
//  Created by Lakhpat on 25/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRStockHolding : NSObject

@property (nonatomic) float purchaseSharePrice;
@property (nonatomic) float currentSharePrice;
@property (nonatomic) int numberOfShares;
@property (nonatomic) NSString *name;

- (float)costInDollars;
- (float)valueInDollars;

@end