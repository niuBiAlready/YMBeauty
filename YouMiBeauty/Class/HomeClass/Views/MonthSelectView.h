//
//  MonthSelectView.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/24.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  NS_ENUM(NSUInteger,EDateFrom){
    
    EDateMonth , //月
    EDateDay     //天
};
@interface MonthSelectView : UIView

#pragma mark 以下是月日历部分
//================================================================

/**
 *  按月计算日历方式
 */
@property (nonatomic , strong)MonthSelectView * monthSelectView;

@property (nonatomic , strong)NSMutableArray    * datesource;
@property (nonatomic , assign)NSInteger         comp;
@property (nonatomic , assign)NSInteger         offpage;//计算当天在第几页
@property (nonatomic , assign)NSInteger         dayOfMonthNum;
@property (nonatomic , assign)EDateFrom         dateFrom;
@property (nonatomic , copy) void(^selectBlock)(NSString *date);
/**
 *  日历背景颜色（按月计算）
 */
@property (nonatomic , strong)UIColor * McalenbarBGcolor;

/**
 *  初始化日历（按月计算），如果日历小于120.0的高度将默认为120.0高度
 *
 *  @param frame 日历大小，位置
 *
 *  @return self
 */
-(id)initM_calenbarviewframe:(CGRect)frame;
- (void)setData;
- (void)getdatesource;

@end
