//
//  Config.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/18.
//  Copyright © 2017年 王涛. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define kSecurityXiaoMiKey @"xiaomisecret"

//#ifdef DEBUG
//# define ServerURL @"http://demo.123xiaomi.com" //测试
//#else
//# define ServerURL @"http://api.123xiaomi.com"
//#endif


#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"

#define  KEY_USERNAME @"com.company.app.username"

#define  KEY_PASSWORD @"com.company.app.password"
#define NUMBERS @"0123456789xX"
#define Number @"123456789"
#define Num_ber @"0123456789."
#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define IOSVersion    [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later                         !(IOSVersion < 7.0)
#define UIBaseFont(a) [UIFont fontWithName:@"STHeitiSC-Light" size:a]

#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define NaviBarHeight                       44.0f
#define TabBarHeight                        49.0f
#define Is4Inch                                 [UtilityFunc is4InchScreen]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGB_AppWhite                            RGB(252.0f, 252.0f, 252.0f)

#define RGB_TextLightGray                       RGB(200.0f, 200.0f, 200.0f)
#define RGB_TextMidLightGray                    RGB(127.0f, 127.0f, 127.0f)
#define RGB_TextDarkGray                        RGB(100.0f, 100.0f, 100.0f)
#define RGB_TextLightDark                       RGB(50.0f, 50.0f, 50.0f)
#define RGB_TextDark                            RGB(10.0f, 10.0f, 10.0f)

#define FLOAT_TitleSizeNormal               18.0f
#define FLOAT_TitleSizeMini                 14.0f
#define RGB_TitleNormal                     RGB(80.0f, 80.0f, 80.0f)
#define RGB_TitleMini                       [UIColor blackColor]
// log
#define APP_Log(...) NSLog(__VA_ARGS__)

// assert
#ifdef ENABLE_ASSERT_STOP
#define APP_ASSERT_STOP                     {LogRed(@"APP_ASSERT_STOP"); NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);}
#define APP_ASSERT(condition)               {NSAssert(condition, @" ! Assert");}
#else
#define APP_ASSERT_STOP                     do {} while (0);
#define APP_ASSERT(condition)               do {} while (0);
#endif
//数字
#define ZCNNUM @"0123456789"
//字母
#define ZCNALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//数字和字母
#define ZCNALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

/**
 * 通用局部粉色背景
 */
#define SubviewNormalBgColor UIColorFromRGB(0xff0057)
/**
 * 通用规则字体颜色
 */
#define PinkTextColor UIColorFromRGB(0xff0057)
#define DarkTextColor UIColorFromRGB(0x4c7598)
#define BlackTextColor UIColorFromRGB(0x383838)
#define GrayTextColor UIColorFromRGB(0xaab7c2)

/**
 *线条颜色 及其线条高度
 */
#define GrayLineViewColor UIColorFromRGB(0xe0e0e0)
#define GrayLineColor UIColorFromRGB(0xaab7c2)
#define BlueLineColor UIColorFromRGB(0x199de8)
#define RedLineColor  UIColorFromRGB(0xdd2e44)
#define BarItemSColor  UIColorFromRGB(0x4c4c4c)
#define Lineheight    0.5f

#define NavBarHeight   64.0
/**
 *  按钮通用颜色状态
 */
#define NormalButtonColor  UIColorFromRGB(0x199de8)
#define EnableButtonColor UIColorFromRGB(0x99cdf5)
#define HightLightButtonColor    UIColorFromRGB(0x99cdf5)

/**
 *导航栏颜色及其文字大小
 */
#define NavbgColor UIColorFromRGB(0xff0057)
#define NavTitleFont18  18.0
#define NavTitleColor UIColorFromRGB(0xffffff)

/**
 *普通单元格返回的高度
 */
#define NormalCellHeight   45.0f

/**
 *错误信息提示字体大小
 */
#define ErrorTitleFont12  UIBaseFont(12.0)

//文字距离左边距离
#define LeftRange 12.0f
#define RightRange 12.0f

//基于6plus进行缩放
//当前设备的宽和320的比例
/** 设备的宽 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 设备的高 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define WRATIO [UIScreen mainScreen].bounds.size.width/414

//基于4寸进行计算,这工程里面连个设计规范都木有,自己采用自己知道的
#define WRATIO_4 [UIScreen mainScreen].bounds.size.width/375

//计算实际比例
#define W(a) ((a) / 2) * WRATIO_4

#define H(a) ((a) / 2) * WRATIO

#define Alipay_ID @"XMA20160524"
#define WeChat_ID @"wxd8adb605adc3dc89"

//获取当前版本号
#define kCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//存储是否是第一次启动
#define kZCNUserDefaultsKeyNotFirstLaunch @"kZCNUserDefaultsKeyNotFirstLaunchVersion"

#define BaiduMapKey @"TQ0OhKldRidhGTOdBclCYDGaB1Us8dPk"

#define UMengAppKey @"5811cce06e27a41342003c0a"


#endif /* Config_h */
