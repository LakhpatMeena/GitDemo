//
//  main.m
//  Callbacks
//
//  Created by Lakhpat on 26/02/16.
//  Copyright (c) 2016 lakhpat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"
#import "BNRObserver.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BNRLogger *logger = [[BNRLogger alloc] init];
        
//        void (^zoneChange)(NSNotification *);
//        zoneChange = ^(NSNotification *note){
//            NSLog(@"Time has changed");
//        };
        
//        [[NSNotificationCenter defaultCenter] addObserverForName:NSSystemTimeZoneDidChangeNotification object:nil queue:nil usingBlock:zoneChange];
        
        
        
        
        
//        [[NSNotificationCenter defaultCenter] addObserver:logger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];
        
//        NSURL *url = [NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
//        __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request delegate:logger startImmediately:YES];
//        
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:25.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
        
        BNRObserver *observer = [[BNRObserver alloc] init];
        
        [logger addObserver:observer forKeyPath:@"lastTime" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}

