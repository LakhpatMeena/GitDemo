//
//  main.m
//  Stockz
//
//  Created by Lakhpat on 26/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *stocks = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *stock;
        
        stock = [NSMutableDictionary dictionary];
        
        [stock setObject:@"AAPL" forKey:@"symbol"];
        [stock setObject:[NSNumber numberWithInt:200] forKey:@"shares"];
        
        [stocks addObject:stock];
        
        /*stock = [NSMutableDictionary dictionary];
        
        [stock setObject:@"DELL" forKey:@"symbol"];
        [stock setObject:[NSNumber numberWithInt:160] forKey:@"shares"];
        
        [stocks addObject:stock];*/
        
        
        NSString *str = @"nice one!";
        NSDate *now = [NSDate date];
        NSNumber *number = [NSNumber numberWithInt:10];
        
        [stocks addObject:str];
        [stocks addObject:now];
        [stocks addObject:number];
        
        
        
        [stocks writeToFile:@"/Users/lakhpat/Desktop/MyFiles/proplist.plist" atomically:YES];
        
        /*NSArray *stockList = [NSArray arrayWithContentsOfFile:@"/Users/lakhpat/Desktop/MyFiles/stocks.plist"];
        
        for (NSDictionary *d in stockList){
            NSLog(@"I have %@ shares of %@", [d objectForKey:@"shares"], [d objectForKey:@"symbol"]);
        }*/
        
    }
    return 0;
}

