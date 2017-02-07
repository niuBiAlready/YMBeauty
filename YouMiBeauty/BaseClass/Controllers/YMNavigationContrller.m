//
//  YMNavigationContrller.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMNavigationContrller.h"

@interface YMNavigationContrller ()

@end

@implementation YMNavigationContrller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarHidden:NO];       // 使导航条有效
    [self.navigationBar setHidden:YES];     // 隐藏导航条，但由于导航条有效，系统的返回按钮页有效，所以可以使用系统的右滑返回手势。
    
    [self navigationCanDragBack:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)bCanDragBack
{
    if (IsiOS7Later)
    {
        self.interactivePopGestureRecognizer.enabled = bCanDragBack;
    }else{}
}

@end
