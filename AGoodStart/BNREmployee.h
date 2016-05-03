//
//  BNREmployee.h
//  AGoodStart
//
//  Created by Lakhpat on 25/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import "BNRPerson.h"

@interface BNREmployee : BNRPerson

@property (nonatomic,readwrite) unsigned int employeeID;
@property (nonatomic,readwrite) NSDate *hireDate;

@end
