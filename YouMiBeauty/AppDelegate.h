//
//  AppDelegate.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/17.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMRootViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)NSInteger allowRotation;
@property (strong, nonatomic) YMRootViewController *rootVC;
-(void)setRootViewController;

@end

