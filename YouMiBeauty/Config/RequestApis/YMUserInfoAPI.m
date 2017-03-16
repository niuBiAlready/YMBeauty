//
//  YMUserInfoAPI.m
//  YouMiBeauty
//
//  Created by Soo on 2017/3/15.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMUserInfoAPI.h"

@implementation YMUserInfoAPI

@end
/**
 获取验证码
 */
@implementation YMLoginGetCodeAPI
{
    NSString *_phoneNum;
}
-(id)initPhoneNum:(NSString*)phoneNum
{
    self =[super init];
    if (self) {
        
        _phoneNum = phoneNum;
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/identity/sign/sendPhoneCode.do";
}
-(id)requestArgument
{
    self.isUserinfo =FALSE;
    self.isSecurity =FALSE;
    
    [super requestArgument];
    NSDictionary *dic = @{@"phone" :_phoneNum};
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
/**
 登录
 */
@implementation YMLoginAPI
{
    NSString *_phoneNum;
    NSString *_code;
}
-(id)initPhoneNum:(NSString*)phoneNum andCode:(NSString *)code
{
    self =[super init];
    if (self) {
        
        _phoneNum   = phoneNum;
        _code       = code;
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/identity/sign/login.do";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
-(id)requestArgument
{
    self.isUserinfo =FALSE;
    self.isSecurity =FALSE;
    
    [super requestArgument];
    NSDictionary *dic = @{@"phone" :_phoneNum,
                          @"code"  :_code};
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
