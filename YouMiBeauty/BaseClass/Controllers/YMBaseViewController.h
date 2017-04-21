//
//  YMBaseViewController.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/18.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCustomNaviBarView.h"

#import "YMNoInternetConnection.h"

@interface YMBaseViewController : UIViewController
@property (nonatomic, strong) YMCustomNaviBarView *viewNaviBar;
@property (nonatomic, strong) YMNoInternetConnection *noConnectionView;
- (void)bringNaviBarToTopmost;

- (void)hideNaviBar:(BOOL)bIsHide;
- (void)setNaviBarTitle:(NSString *)strTitle;
- (void)setNaviBarLeftBtn:(UIButton *)btn;
- (void)setNaviBarRightBtn:(UIButton *)btn frame:(CGRect)frame;
- (void)setNaviBarRightLabel:(UILabel*)lab;

- (void)naviBarAddCoverView:(UIView *)view;
- (void)naviBarAddCoverViewOnTitleView:(UIView *)view;
- (void)naviBarRemoveCoverView:(UIView *)view;

-(void)hiddenBackBtn:(BOOL)isHidden;
// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)bCanDragBack;
- (void)requestFromSever;

/**
 *  吐司
 *
 *  @param title
 */
-(void)showMBHud:(NSString*)title;
/**
 *  发送请求
 *
 *  @param title
 */
-(void)showSenderToServer:(NSString*)title;
-(void)hiddenMBHud;
- (BOOL)willDealloc ;
/**
 *  判断是否登录
 */
- (void)isLogin:(UIViewController *)controller;
@end
