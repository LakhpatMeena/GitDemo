//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Lakhpat on 04/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
