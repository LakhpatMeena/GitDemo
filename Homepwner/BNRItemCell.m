//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Lakhpat on 05/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell
- (IBAction)showImage:(id)sender {
    if (self.actionBlock){
        self.actionBlock();
    }
}

@end
