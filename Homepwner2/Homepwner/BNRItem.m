//
//  BNRItem.m
//  Homepwner
//
//  Created by Lakhpat on 02/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

+ (instancetype)randomItem
{
    NSArray *randomList = @[@"ali", @"lucky"];
    NSArray *randomNList = @[@"bear", @"spork"];
    
    NSInteger adjIndex = arc4random()%[randomList count];
    NSInteger nIndex = arc4random()%[randomNList count];
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",[randomList objectAtIndex:adjIndex],[randomNList objectAtIndex:nIndex]];
    int randValue = arc4random()%100;
    NSString *randSerialN = [NSString stringWithFormat:@"%c%c%c%c%c",'0' + arc4random()%10,'A' + arc4random()%26,'0' + arc4random()%10,'A' + arc4random()%26,'0' + arc4random()%10];
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randValue serialNumber:randSerialN];
    return newItem;
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
{
    // Call the superclass's designated initializer
    self = [super init];
    // Did the superclass's designated initializer succeed?
    if (self) {
        // Give the instance variables initial values
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        // Set _dateCreated to the current date and time
        _dateCreated = [[NSDate alloc] init];
    }
    // Return the address of the newly initialized object
    return self;
}

- (instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}
- (instancetype)init
{
    return [self initWithItemName:@"Item"];
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): worth $%d, recorded on %@",self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
    return descriptionString;
}

@end
