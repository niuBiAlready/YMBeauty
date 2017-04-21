//
//  YMUserInfoAPI.h
//  YouMiBeauty
//
//  Created by Soo on 2017/3/15.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseRequest.h"

@interface YMUserInfoAPI : YMBaseRequest

@end

/**
 获取验证码
 */
@interface YMLoginGetCodeAPI : YMBaseRequest
-(id)initPhoneNum:(NSString*)phoneNum;
@end

/**
 登录
 */
@interface YMLoginAPI : YMBaseRequest
- (id)initPhoneNum:(NSString*)phoneNum andCode:(NSString *)code;
@end
/**
 获取app版本号
 */
@interface YMSearchVersionAPI : YMBaseRequest

@end
/**
 获取管理者相关店铺
 */
@interface YMGetManagerStoreAPI : YMBaseRequest

@end
/**
 获取美容师权限（只有美容师需要获取）
 */
@interface YMGetCosmetologistAPI : YMBaseRequest

@end
/**
 流水查询 - 等待确认
 */
@interface YMHomeWaitingForConfirmationAPI : YMBaseRequest
- (id)initStatus:(NSString*)status andPage:(NSInteger)page;
@end
/**
 流水查询 - 流水明细
 */
@interface YMHomeMoneyDetailAPI : YMBaseRequest
- (id)initStatus:(NSString*)status andYear:(NSInteger )year andMonth:(NSInteger )month andDay:(NSInteger )day andPage:(NSInteger)page;
@end

/**
 流水查询 - 套餐到期
 */
@interface YMHomeExpireAPI : YMBaseRequest
- (id)initStatus:(NSString*)status andExpire:(NSString *)expire andPage:(NSInteger)page;
@end


/*******************************************/
//美容师
/**
 美容师
 */
@interface YMCosmetologistAPI : YMBaseRequest
- (id)initName:(NSString*)name;
@end

/*******************************************/
//客户
/**
 客户
 */
@interface YMCustomerAPI : YMBaseRequest
- (id)initName:(NSString*)name;
@end




