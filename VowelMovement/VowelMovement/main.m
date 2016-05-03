//
//  main.m
//  VowelMovement
//
//  Created by Lakhpat on 26/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ArrayWithEnumerateBlock)(id, NSUInteger, BOOL *);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *originalString = @[@"Lakhpat", @"Ramesh", @"Sikandar"];
        
        NSLog(@"original strings %@",originalString);
        
        NSMutableArray *devoelisedStrings = [NSMutableArray array];
        
        NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
        
        //void (^devoweliser)(id, NSUInteger, BOOL *);
        
        ArrayWithEnumerateBlock devoweliser;
        
        devoweliser = ^(id string, NSUInteger i, BOOL *stop){
            
            NSRange nRange = [string rangeOfString:@"e" options:NSCaseInsensitiveSearch];
            
            if (nRange.location != NSNotFound) {
                *stop = YES;
                return;
            }
            
            NSMutableString *newString = [NSMutableString stringWithString:string];
            
            for(NSString *s in vowels){
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
            }
            
            [devoelisedStrings addObject:newString];
            
        };
        
        [originalString enumerateObjectsUsingBlock:devoweliser];
        NSLog(@"devowelised strings %@", devoelisedStrings);
        
    }
    return 0;
}

