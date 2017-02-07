//
//  WaitingConfirmationModel.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/23.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseModel.h"

@interface WaitingConfirmationModel : YMBaseModel

/**
 *  用户id
 */
@property(nonatomic,copy) NSString *userID;
/**
 *  头像
 */
@property(nonatomic,copy) NSString *icon;
/**
 *  名字
 */
@property(nonatomic,copy) NSString *name;
/**
 *  描述
 */
@property(nonatomic,copy) NSString *descriptionText;
/**
 *  状态
 */
@property(nonatomic,copy) NSString *status;
/**
 *  日期
 */
@property(nonatomic,copy) NSString *date;
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
