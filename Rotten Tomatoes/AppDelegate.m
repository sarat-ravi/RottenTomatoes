//
//  AppDelegate.m
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/5/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    
    MoviesViewController *moviesVC = [[MoviesViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:moviesVC];
    navigationController.navigationBar.translucent = NO;
    self.window.rootViewController = navigationController;
    
    CGFloat textColor = 0.90;
    CGFloat separatorColor = 0.30;
    CGFloat backgroundColor = 0.20;
    CGFloat barTintColor = 0.15;
    CGFloat tintColor = 0.99;
    CGFloat navTitleColor = 0.99;
    
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:barTintColor green:barTintColor blue:barTintColor alpha:1.0];
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:tintColor green:tintColor blue:tintColor alpha:1.0];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor colorWithRed:navTitleColor green:navTitleColor blue:navTitleColor alpha:1.0], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    // [[UINavigationBar appearance] setBackgroundColor: [UIColor colorWithRed:barTintColor green:barTintColor blue:barTintColor alpha:1.0]];
    [[UITableView appearance] setSeparatorColor: [UIColor colorWithRed:separatorColor green:separatorColor blue:separatorColor alpha:0.0]];
    [[UILabel appearance] setTextColor: [UIColor colorWithRed:textColor green:textColor blue:textColor alpha:1.0]];
    [[UIView appearanceWhenContainedIn:[MoviesViewController class], nil] setBackgroundColor: [UIColor colorWithRed:backgroundColor
                                                                                                              green:backgroundColor
                                                                                                               blue:backgroundColor
                                                                                                              alpha:1.0]];
    // [[UIView appearance] setBackgroundColor: [UIColor blackColor]];
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
