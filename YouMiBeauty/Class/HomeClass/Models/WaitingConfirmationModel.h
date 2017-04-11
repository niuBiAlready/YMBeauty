//
//  WaitingConfirmationModel.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/23.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseModel.h"

@interface WaitingConfirmationModel : YMBaseModel

@property(nonatomic,copy) NSString *ref_id;
/**
 *  头像
 */
@property(nonatomic,copy) NSString *icon;

@property(nonatomic,copy) NSString *salon_id;

@property(nonatomic,copy) NSString *insert_time;

@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *manager_id;
@property(nonatomic,copy) NSString *customer_tip;
@property(nonatomic,copy) NSString *expire;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *customer_name;
@property(nonatomic,copy) NSString *detail;
@property(nonatomic,copy) NSString *customer_id;
@property(nonatomic,copy) NSString *status;
/**
 *  日期
 */
@property(nonatomic,copy) NSString *date;
/**
 *  年
 */
@property(nonatomic,copy) NSString *year;
/**
 *  月
 */
@property(nonatomic,copy) NSString *month;
/**
 *  日
 */
@property(nonatomic,copy) NSString *day;
/**
 *  时间
 */
@property(nonatomic,copy) NSString *time;
/**
 *  分组日期
 */
@property(nonatomic,copy) NSString *groupTime;
/**
 *  按钮状态
 */
@property(nonatomic,assign) BOOL  isSelected;
/**
 *  分组
 */
@property(nonatomic,strong) NSArray *datalist;
@end
