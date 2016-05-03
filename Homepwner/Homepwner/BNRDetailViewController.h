//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Lakhpat on 03/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic, strong) BNRItem *item;

@end
