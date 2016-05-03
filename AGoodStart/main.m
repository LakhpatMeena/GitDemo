//
//  main.m
//  AGoodStart
//
//  Created by Lakhpat on 25/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BNRPerson.h"
#import "BNREmployee.h"

@implementation BNRPerson

@synthesize height;
@synthesize weight;
- (float)BMI
{
    return self.weight/ (self.height * self.height);
}

@end


@implementation BNREmployee

@synthesize employeeID;
//@synthesize officeAlarmCode;
@synthesize hireDate;


//- (void)setAssets:(NSArray *)a
//{
//    assets = [a mutableCopy];
//}
//
//- (NSArray *)assets
//{
//    return [assets copy];
//}
//
//- (void)addAsset:(BNRAsset *)a
//{
//    if(!assets)
//    {
//        assets = [[NSMutableArray alloc] init];
//    }
//    [assets addObject:a];
//}
//
//- (unsigned int)valueOfAssets
//{
//    unsigned int sum = 0;
//    for (BNRAsset *a in assets)
//    {
//        sum += [a resaleValue];
//    }
//    return sum;
//}

- (double)yearsOfEmployment
{
    if(self.hireDate)
    {
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate:self.hireDate];
        return secs/31557600.0;
    }
    else
    {
        return 0;
    }
}

- (float)BMI
{
    return [super BMI];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Employee %u: %@>",
            self.employeeID,self.hireDate];
}

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}


@end


//@implementation BNRAsset
//
//@synthesize label;
//@synthesize resaleValue;
//
//
//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"<%@: $%u>", self.label, self.resaleValue];
//}
//
//- (void)dealloc
//{
//    NSLog(@"deallocating %@", self);
//}
//
//@end



int main (int argc, const char * argv[])
{
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    @autoreleasepool {
    NSMutableArray *employees = [[NSMutableArray alloc] init];
    NSMutableDictionary *storage = [[NSMutableDictionary alloc] init];
    BNREmployee *lucky = [[BNREmployee alloc] init];
    [lucky setWeight:65];
    lucky.height = 1.8;
    lucky.employeeID = 12;
    lucky.hireDate = [NSDate dateWithNaturalLanguageString:@"Aug 2nd, 2010"];
    
    BNREmployee *ilucky = [[BNREmployee alloc] init];
    [ilucky setWeight:65];
    ilucky.height = 1.8;
    ilucky.employeeID = 13;
    ilucky.hireDate = [NSDate dateWithNaturalLanguageString:@"Aug 2nd, 2011"];
    
    [storage setObject:lucky forKey:@"lucky"];
    [storage setObject:ilucky forKey:@"ilucky"];
    
    [employees addObject:lucky];
    [employees addObject:ilucky];
    
    NSSortDescriptor *sid = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    NSSortDescriptor *eid = [NSSortDescriptor sortDescriptorWithKey:@"hireDate" ascending:YES];
    
    [employees sortUsingDescriptors:@[sid,eid]];
    NSLog(@"employees : %@",employees);
    
    NSPredicate *filt = [NSPredicate predicateWithFormat:@"employeeID > 12"];
    NSArray *filtered = [employees filteredArrayUsingPredicate:filt];
    NSLog(@"employees filtered : %@",filtered);
    filtered = nil;
    
    NSLog(@"Details of lucky %@ height : %.1f weight: %d",lucky,[lucky height],lucky.weight);
	NSLog(@"lucky (%u) hired on : %@",lucky.employeeID,lucky.hireDate);
    
    NSLog(@"BMI : %.2f",[lucky BMI]);
    
    NSLog(@"worked here for %.2f years",[lucky yearsOfEmployment]);
    
    NSLog(@"All employees : %@",storage);
    NSLog(@"lucky : %@",storage[@"lucky"]);
    }
    return 0;
}