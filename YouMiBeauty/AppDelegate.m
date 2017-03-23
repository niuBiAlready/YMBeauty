//
//  AppDelegate.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/17.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "AppDelegate.h"
#import "YMNavigationContrller.h"
#import "YMGuideViewController.h"
@interface AppDelegate ()<YMGuideViewControllerDelegate>

{
    YMGuideViewController *guideVC;
    BOOL isbackground;
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [application setApplicationIconBadgeNumber:0];
    
    [NSThread sleepForTimeInterval:1.0];
    [self setRootViewController];
    
    return YES;
}

-(void)setRootViewController
{
    
    if (![YMCommonUtils checkIsNotFirstLaunch])
    {
        guideVC =[YMGuideViewController new];
        guideVC.delegate =self;
        self.window.rootViewController = guideVC;
        [self.window reloadInputViews];
    }
    else
    {
        _rootVC = [[YMRootViewController alloc] init];
        
        YMNavigationContrller *nav = [[YMNavigationContrller alloc] initWithRootViewController:_rootVC];
        self.window.rootViewController =nav;
        [self versionCheck];
        
    }
    //    [rootVC remoteNotificationjumpToVC:0];
}
-(void)versionCheck
{
    //    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://itunes.apple.com/lookup?id=1091516243"] encoding:NSUTF8StringEncoding error:nil];
    //    if (string!=nil&&string.length>0&&[string rangeOfString:@"version"].length==7) {
    //        [self checkUpdate:string];
    //    }
//    NSString *urlStr = @"https://itunes.apple.com/cn/lookup?id=1091516243";
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    [NSURLConnection connectionWithRequest:req delegate:self];
}
-(void)guideDoneToShowApp:(YMGuideViewController *)controller imageView:(UIImageView*)image
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:kCurrentVersion forKey:kZCNUserDefaultsKeyNotFirstLaunch];
    [userDefaults synchronize];
    [UIView animateWithDuration:1.5 animations:^{
        image.alpha=0.0;
        //        guideVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [guideVC.view removeFromSuperview];
    }];
    _rootVC = [[YMRootViewController alloc] init];
    
    YMNavigationContrller *nav = [[YMNavigationContrller alloc] initWithRootViewController:_rootVC];
    self.window.rootViewController =nav;
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

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
