//
//  YMCustomerModel.h
//  YouMiBeauty
//
//  Created by Soo on 2017/2/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseModel.h"

//客户数据
@interface YMCustomerModel : YMBaseModel
/**
 *  用户id
 */
@property(nonatomic,copy) NSString *id;
/**
 *  用户名字
 */
@property(nonatomic,copy) NSString *name;

/**
 *  用户联系方式
 */
@property(nonatomic,copy) NSString *phone;
/**
 *  生日
 */
@property(nonatomic,copy) NSString *birthday;
/**
 *  金额
 */
@property(nonatomic,copy) NSString *balance;
/**
 *  消费
 */
@property(nonatomic,copy) NSString *consume;
/**
 *  加入时间
 */
@property(nonatomic,copy) NSString *insert_time;
/**
 *  跟新时间
 */
@property(nonatomic,copy) NSString *update_time;
/**
 *  微信
 */
@property(nonatomic,copy) NSString *wechat_id;
@end

//美容师数据
@interface YMCosmetologist : YMBaseModel
/**
 *  用户id
 */
@property(nonatomic,copy) NSString *id;
/**
 *  用户名字
 */
@property(nonatomic,copy) NSString *name;

/**
 *  用户联系方式
 */
@property(nonatomic,copy) NSString *phone;
/**
 *  生日
 */
@property(nonatomic,copy) NSString *birthday;
/**
 *  类型
 */
@property(nonatomic,copy) NSString *type;

@end
