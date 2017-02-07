//
//  YMRootViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMRootViewController.h"
#import "YMNavigationContrller.h"
#import "LCTabBar.h"
#import "AppDelegate.h"

#import "YMHomeMainViewController.h"
#import "YMCustomerViewController.h"
#import "YMCosmetologistViewController.h"
#import "YMManageViewController.h"

#define HYTNotificationCenter [NSNotificationCenter defaultCenter]

@interface YMRootViewController ()<LCTabBarDelegate>
@property (nonatomic, strong) LCTabBar *lcTabBar;


@end

@implementation YMRootViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BarItemSColor,NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PinkTextColor,NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateSelected];
    
}

-(void) removeTabBarButton {
    
    // 删除系统自动生成的UITabBarButton
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:[UIControl class]]) {
            
            [child removeFromSuperview];
            
        }
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    /**
     *   首页主视图
     */
    YMHomeMainViewController *homeMainViewController = [[YMHomeMainViewController alloc] init];
    homeMainViewController.tabBarItem.title = @"流水";
    homeMainViewController.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_1_normal"];
    homeMainViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_1_selected"];
    /**
     *   发现主视图
     */
    YMCustomerViewController *customerViewController = [YMCustomerViewController new];
    customerViewController.tabBarItem.title = @"客户";
    customerViewController.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_2_normal"];
    customerViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_2_selected"];
    
    
    /**
     *
     *   兼职主视图
     */
    YMCosmetologistViewController *cosmetologistViewController = [[YMCosmetologistViewController alloc] init];
    cosmetologistViewController.tabBarItem.title = @"美容师";
    cosmetologistViewController.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_3_normal"];
    cosmetologistViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_3_selected"];
    
    /**
     *
     *   我的主视图
     */
    YMManageViewController *manageViewController = [[YMManageViewController alloc] init];
    manageViewController.tabBarItem.title = @"管理";
    manageViewController.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_4_normal"];
    manageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_4_selected"];
    
    YMNavigationContrller *homeNav = [[YMNavigationContrller alloc] initWithRootViewController:homeMainViewController];
    YMNavigationContrller *customerNav = [[YMNavigationContrller alloc] initWithRootViewController:customerViewController];
    
    YMNavigationContrller *cosmetologistNav = [[YMNavigationContrller alloc] initWithRootViewController:cosmetologistViewController];
    YMNavigationContrller *manageNav = [[YMNavigationContrller alloc] initWithRootViewController:manageViewController];
    self.viewControllers = @[homeNav,customerNav,cosmetologistNav,manageNav];
    
}

/**
 *  接收到消息跳转不同的VC
 *
 */
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
-(void)remoteNotificationjumpToVC:(NSInteger)type webUrl:(NSString*)pageurl guanlianID:(NSString*)guanlianid secondID:(NSString*)secondid islogin:(NSString*) islogin
{
    
    
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:VC];
        
        // 添加tabBarView内部按钮
        [self.lcTabBar addTabBarItem:VC.tabBarItem];
    }];
}
//
-(void)setSelectedIndexFromWithIndex:(NSInteger )index
{
    [self setSelectedIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    //    NSLog(@"item --- %@",item.title);
    if ([item.title isEqualToString:@"流水"]) {
        //        NSLog(@"0");
    }else if ([item.title isEqualToString:@"客户"]){
        
        //        NSLog(@"1");
    }else if([item.title isEqualToString:@"美容师"]){
        
        //        NSLog(@"2");
    }else if ([item.title isEqualToString:@"管理"]){
    
    }

}


@end
