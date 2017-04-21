//
//  YMNoInternetConnection.h
//  YouMiBeauty
//
//  Created by Soo on 2017/4/20.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NoDataAndNoInternet) {
    
    EFNoData,//无数据
    EFNoInternet,//无网络
};

@interface YMNoInternetConnection : UIView

@property (nonatomic, strong) void(^clickBlock)(void);
@property(nonatomic,assign) NoDataAndNoInternet noConOrnoData;
- (instancetype)initWithFrame:(CGRect)frame andType:(NoDataAndNoInternet)noConOrnoData;
- (void)hiddenNoConnectionView;

@end
