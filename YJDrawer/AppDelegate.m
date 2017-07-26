//
//  AppDelegate.m
//  YJDrawer
//
//  Created by wanyongjian on 2017/6/21.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "AppDelegate.h"
#import "MessageController.h"
#import "ContactController.h"
#import "NewsController.h"
#import "YJTabBarController.h"
#import "LeftViewController.h"
#import "YJDrawerManager.h"
#import "LeftView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
    
    YJTabBarController *tabbar = [[YJTabBarController alloc] init];
    LeftView *leftView = [[LeftView alloc]initWithFrame:CGRectMake(-self.window.frame.size.width * kLeftViewWidthScale, 0, KScreenWidth, KScreenHeight)];
    [[YJDrawerManager instance] initController:tabbar andView:leftView];

//    [self.window makeKeyAndVisible];
    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, [UIScreen mainScreen].bounds.size.height)];
//    view.backgroundColor = [UIColor blackColor];
//    [self.window addSubview:view];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
