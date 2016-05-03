//
//  main.m
//  BNRAppliance
//
//  Created by Lakhpat on 29/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BNRAppliance *app = [[BNRAppliance alloc] init];
        NSLog(@"a is %@",app);
        [app setValue:@"Washing Machine" forKey:@"productName"];
        [app setVoltage:240];
        NSLog(@"a is %@",app);
        
    }
    return 0;
}

