//
//  BNRLine.h
//  TouchTracker
//
//  Created by Lakhpat on 04/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRLine : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;

@property (nonatomic, strong) NSMutableArray *containingArray;

@end
