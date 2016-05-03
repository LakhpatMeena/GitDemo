//
//  BTAppDelegate.m
//  OrderTracker
//
//  Created by Lakhpat on 05/03/16.
//  Copyright (c) 2016 Accolite. All rights reserved.
//

#import "BTAppDelegate.h"
#import "BTHomeViewController.h"
#import "BTHomeScreenViewController.h"
#import "BTOrderDetailViewController.h"

@implementation BTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //NSBundle *appBundle = [NSBundle mainBundle];
    //BTHomeViewController *btHome = [[BTHomeViewController alloc] initWithNibName:@"BTHomeViewController" bundle:appBundle];
    //self.window.rootViewController = btHome;
    
    BTHomeScreenViewController *btHomeScreen = [[BTHomeScreenViewController alloc] init];
    
    //BTOrderDetailViewController *odvc = [[BTOrderDetailViewController alloc] initWithNibName:@"BTOrderDetailViewController" bundle:appBundle];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:btHomeScreen];
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    
    self.window.rootViewController = nvc;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    for (NSString *family in [UIFont familyNames]) {
        NSLog(@"%@", family);
        for (NSString *name in [UIFont fontNamesForFamilyName:family]) {
            NSLog(@" %@",name);
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
