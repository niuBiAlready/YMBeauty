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
/**
 流水查询 - 等待确认
 
 */
@implementation YMHomeWaitingForConfirmationAPI
{

    NSString *_status;
    NSString *_page;
}
-(id)initStatus:(NSString*)status andPage:(NSInteger )page
{
    self =[super init];
    if (self) {
        
        _status = status;
        _page   = [NSString stringWithFormat:@"%ld",page];
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/record/recordIndex/searchSalonStreamList.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    
    [super requestArgument];
    NSDictionary *dic = @{
                          @"salonId" :userInfo.salon_id,
                          @"status":_status,
                          @"page":_page
                          };
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
/**
 流水查询 - 流水明细
 
 */
@implementation YMHomeMoneyDetailAPI
{
    
    NSString *_status;
    NSString *_page;
    NSString *_year;
    NSString *_month;
    NSString *_day;
    
}
-(id)initStatus:(NSString*)status andYear:(NSInteger )year andMonth:(NSInteger )month andDay:(NSInteger )day andPage:(NSInteger)page
{
    self =[super init];
    if (self) {
        
        _status = status;
        _page   = [NSString stringWithFormat:@"%ld",page];
        _year   = [NSString stringWithFormat:@"%ld",year];
        _month  = [NSString stringWithFormat:@"%ld",month];
        _day    = [NSString stringWithFormat:@"%ld",day];
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/record/recordIndex/searchSalonStreamList.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    
    [super requestArgument];
    NSDictionary *dic = @{
                          @"salonId" :userInfo.salon_id,
                          @"status":_status,
                          @"page":_page,
                          @"year":_year,
                          @"month":_month,
                          @"day":_day
                          };
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end

/**
 流水查询 - 套餐到期
 
 */
@implementation YMHomeExpireAPI
{
    
    NSString *_status;
    NSString *_page;
    NSString *_expire;
    
}
-(id)initStatus:(NSString*)status andExpire:(NSString *)expire andPage:(NSInteger)page
{
    self =[super init];
    if (self) {
        
        _status = status;
        _page   = [NSString stringWithFormat:@"%ld",page];
        _expire = expire;
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/record/recordIndex/searchSalonStreamList.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    
    [super requestArgument];
    NSDictionary *dic = @{
                          @"salonId" :userInfo.salon_id,
                          @"status":_status,
                          @"page":_page,
                          @"expire":_expire
                          };
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end

/*******************************************/
//美容师
/**
 美容师
 */
@implementation YMCosmetologistAPI
{
    NSString *_name;
    
}
-(id)initName:(NSString *)name
{
    self =[super init];
    if (self) {
        
        _name   = name;
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/core/baseIndex/searchSalonManagerList.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    
    [super requestArgument];
    NSDictionary *dic = @{
                          @"salonId" :userInfo.salon_id,
                          @"name":_name,
                          };
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
/*******************************************/
//客户
/**
 客户
 */
@implementation YMCustomerAPI
{
    NSString *_name;
    
}
-(id)initName:(NSString *)name
{
    self =[super init];
    if (self) {
        
        _name   = name;
        
    }
    return self;
}
-(NSString*)requestUrl
{
    return @"/core/baseIndex/searchSalonCustomerList.do";
}
-(id)requestArgument
{
    self.isUserinfo =TRUE;
    self.isSecurity =FALSE;
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    
    [super requestArgument];
    NSDictionary *dic = @{
                          @"salonId" :userInfo.salon_id,
                          @"name":_name,
                          };
    [self.baseDic addEntriesFromDictionary:dic];
    return [YMCommonUtils securityMethod:self.baseDic isSecurity:NO];
}
@end
