//
//  BNRPerson.h
//  AGoodStart
//
//  Created by Lakhpat on 25/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRPerson : NSObject

@property (nonatomic,readwrite) float height;
@property (nonatomic,readwrite) int weight;

- (float)BMI;


@end
