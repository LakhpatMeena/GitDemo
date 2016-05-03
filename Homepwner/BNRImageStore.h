//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Lakhpat on 04/03/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
