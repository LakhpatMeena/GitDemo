//
//  BNRPortfolio.h
//  Collection
//
//  Created by Lakhpat on 25/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRStockHolding.h"

@interface BNRPortfolio : NSObject
{
    NSMutableArray *stocks;
}

@property (nonatomic, copy) NSArray *stocks;


- (void)addStocks:(BNRStockHolding *)a;
- (float)totalValue;
- (NSArray *)topTwo;

@end
