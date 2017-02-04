//
//  AppDelegate.m
//  TwitterDemo
//
//  Created by  Michael Lin on 1/30/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetListViewController.h"
#import "TweetDetailViewController.h"
#import "ProfileViewController.h"
#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    //TweetListViewController *tweetListViewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:frame];
    
    //self.window.rootViewController = tweetListViewController;
    self.window.rootViewController = loginViewController;

    
    // For debugging
    //TweetDetailViewController *tweetDetailViewController = [[TweetDetailViewController alloc] initWithNibName:@"TweetDetailViewController" bundle:nil];
    //self.window.rootViewController = tweetDetailViewController;
    //ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    //self.window.rootViewController = composeViewController;
    //ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    //self.window.rootViewController = profileViewController;
    
    
    [self.window makeKeyAndVisible];
    
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

- (bool)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[TwitterClient sharedInstance] openURL:url];
    return YES;
}

@end
