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
/**
 获取app版本号
 */
@implementation YMSearchVersionAPI

-(id)init
{
    self =[super init];
    if (self) {
        

    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/identity/setting/searchVersion.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    [super requestArgument];

    NSDictionary *dic = @{@"type" :@"2"};
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
/**
 获取管理者相关店铺
 */
@implementation YMGetManagerStoreAPI

-(id)init
{
    self =[super init];
    if (self) {
        
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/identity/setting/searchSalon.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    [super requestArgument];
    
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
/**
 获取美容师权限（只有美容师需要获取）
 
 */
@implementation YMGetCosmetologistAPI

-(id)init
{
    self =[super init];
    if (self) {
        
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/identity/salon/searchPower.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    
    [super requestArgument];
    NSDictionary *dic = @{@"salonId" :userInfo.salon_id};
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
