//
//  BNRItem.h
//  Homepwner
//
//  Created by Lakhpat on 02/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic) NSString *itemName;
@property (nonatomic)   NSString *serialNumber;
 @property (nonatomic)   int valueInDollars;
@property (nonatomic)    NSDate *dateCreated;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

@end
