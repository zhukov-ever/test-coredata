//
//  AppDelegate.m
//  test-coredata
//
//  Created by Zhn on 2/12/2014.
//  Copyright (c) 2014 Zhn. All rights reserved.
//

#import "AppDelegate.h"
#import "CatManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[CatManager shared] saveContext];
}




@end
