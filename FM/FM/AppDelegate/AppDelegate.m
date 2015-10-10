//
//  AppDelegate.m
//  FM
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 YT. All rights reserved.
//
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
#import "DiscoverController.h"
#import "RadioController.h"
#import "MineController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AVOSCloud setApplicationId:@"gygk6k80xeVgrlVM2PkeEzsW"
                      clientKey:@"PupC2Jsgb9wzzaDOuyW8hExC"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    //1
    DiscoverController *discoverVC = [[DiscoverController alloc]init];
    UINavigationController *discoverNC = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    discoverVC.title = @"发现";
    UIImage *image1 = [UIImage imageNamed:@"faxian"];
    discoverVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:image1 selectedImage:image1];

    //2
    RadioController *radioVC = [[RadioController alloc]init];
    UINavigationController *RadioNC = [[UINavigationController alloc]initWithRootViewController:radioVC];
    radioVC.title = @"电台";
    UIImage *image2 = [UIImage imageNamed:@"diantai"];
    radioVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"电台" image:image2 selectedImage:image2];
    
    //3
    MineController *mineVC = [MineController new];
    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    mineVC.title = @"我的";
    UIImage *image4 = [UIImage imageNamed:@"mine"];
    mineVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:image4 selectedImage:image4];
    

    
    NSArray *allNC = @[discoverNC,RadioNC,mineNC];
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    
    tabBarVC.viewControllers = allNC;
    
    tabBarVC.tabBar.tintColor = [UIColor orangeColor];
    
    self.window.rootViewController = tabBarVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
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

@end
