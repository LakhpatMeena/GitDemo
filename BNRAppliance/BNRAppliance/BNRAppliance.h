//
//  BNRAppliance.h
//  BNRAppliance
//
//  Created by Lakhpat on 29/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRAppliance : NSObject
{
    NSString *productName;
}
//@property (nonatomic, copy) NSString *productName;
@property (nonatomic) int voltage;

- (instancetype) initWithProductName:(NSString *)pn;

@end
