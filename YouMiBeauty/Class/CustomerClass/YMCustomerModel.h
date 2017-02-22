//
//  YMCustomerModel.h
//  YouMiBeauty
//
//  Created by Soo on 2017/2/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseModel.h"

@interface YMCustomerModel : YMBaseModel
/**
 *  用户id
 */
@property(nonatomic,copy) NSString *uid;
/**
 *  用户名字
 */
@property(nonatomic,copy) NSString *nickname;

/**
 *  用户头像
 */
@property(nonatomic,copy) NSString *picurl;
@end
