//
//  main.m
//  Collection
//
//  Created by Lakhpat on 25/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRPortfolio.h"


@implementation BNRPortfolio

@synthesize stocks;

- (void)addStocks:(BNRStockHolding *)a
{
    if(!stocks)
    {
        stocks = [[NSMutableArray alloc] init];
    }
    [stocks addObject:a];
}

- (float)totalValue
{
    float sum = 0.0;
    for(BNRStockHolding *a in self.stocks){
        sum += [a valueInDollars];
    }
    return sum;
}

- (NSArray *)topTwo
{
    NSSortDescriptor *sid = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    [stocks sortUsingDescriptors:@[sid]];
    if([stocks count]>2){
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        [temp addObject:[stocks objectAtIndex:0]];
        [temp addObject:[stocks objectAtIndex:1]];
        [temp addObject:[stocks objectAtIndex:2]];
        return [temp copy];
    }
    else{
        return stocks;
    }
}

@end


@implementation BNRStockHolding

@synthesize purchaseSharePrice;
@synthesize currentSharePrice;
@synthesize numberOfShares;
@synthesize name;

- (float)costInDollars
{
    return [self purchaseSharePrice]*[self numberOfShares];
}

- (float)valueInDollars
{
    return [self currentSharePrice]*[self numberOfShares];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<value in dollers : %.2f>",
            self.valueInDollars];
}
@end


int main (int argc, const char * argv[])
{
    @autoreleasepool {
    
    BNRStockHolding *holder1 = [[BNRStockHolding alloc] init];
    BNRStockHolding *holder2 = [[BNRStockHolding alloc] init];
    BNRStockHolding *holder3 = [[BNRStockHolding alloc] init];
    
    [holder1 setPurchaseSharePrice:2.30];
    [holder1 setCurrentSharePrice:4.50];
    [holder1 setNumberOfShares:40];
    [holder1 setName:@"lucky1"];
    
    [holder2 setPurchaseSharePrice:12.19];
    [holder2 setCurrentSharePrice:10.56];
    [holder2 setNumberOfShares:90];
    [holder2 setName:@"lucky2"];
    
    [holder3 setPurchaseSharePrice:45.10];
    [holder3 setCurrentSharePrice:49.51];
    [holder3 setNumberOfShares:210];
    [holder3 setName:@"lucky3"];
    
    BNRPortfolio *stock = [[BNRPortfolio alloc] init];
    [stock addStocks:holder1];
    [stock addStocks:holder2];
    [stock addStocks:holder3];
    
    NSLog(@"holder detaills :");
    for(BNRStockHolding *h in stock.stocks){
     NSLog(@"Name of stock : %@",h.name);
     NSLog(@"______________________________________________________");
     }
    
    NSLog(@"totalValueInDollars : %.2f",[stock totalValue]);
    
    NSLog(@"top two : %@",[stock topTwo]);
    }
    return 0;
}


