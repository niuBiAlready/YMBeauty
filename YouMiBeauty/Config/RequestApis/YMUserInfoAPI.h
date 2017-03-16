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
