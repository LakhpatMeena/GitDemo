//
//  BNRObserver.m
//  Callbacks
//
//  Created by Lakhpat on 29/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRObserver.h"

@implementation BNRObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    NSString *newValue = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"observed : %@ of %@ was changed from %@ to %@",keyPath,object, oldValue, newValue);
}

@end
