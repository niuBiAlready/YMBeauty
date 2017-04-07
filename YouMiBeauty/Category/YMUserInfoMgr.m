//
//  YMUserInfoMgr.m
//  YouMiBeauty
//
//  Created by Soo on 2017/3/29.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMUserInfoMgr.h"

#define kUserInfoKey     @"kUserInfoKey"

static YMUserInfoMgr *_shareInstance = nil;

@implementation YMUserInfoData

- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}
@end

@interface YMUserInfoMgr()
{
    YMUserInfoData  *_userInfo;
}
@end

@implementation YMUserInfoMgr

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _userInfo   = [self loadUserProfile];
    }
    
    return self;
}

- (void)dealloc
{
    
}

+ (instancetype)sharedInstance;
{
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _shareInstance = [[YMUserInfoMgr alloc] init];
    });
    return _shareInstance;
}

+ (BOOL)isLogin{
    
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
    if(userInfo.token.length > 0)
    {
        return YES;
    }
    return NO;
}

/**
 退出
 */
- (void)logout
{
    _userInfo.token = @"";
    [self saveToLocal];
}

#pragma mark 内存中查询或者修改数据
- (void)setUserInfoData:(YMUserInfoData *)userInfo
{
    _userInfo.token = userInfo.token;
    _userInfo.userID = userInfo.userID;
    _userInfo.userName = userInfo.userName;
    _userInfo.phone = userInfo.phone;
    _userInfo.manager_id = userInfo.manager_id;
    _userInfo.salon_id = userInfo.salon_id;
    _userInfo.salonMapList = userInfo.salonMapList;

    __weak typeof(self) weakself= self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself saveToLocal];
    });
    
}

/**
 *  用于获取用户资料信息借口
 *
 *  @return 用户资料信息结构体指针
 */
- (YMUserInfoData*)getUserProfile
{
    if(!_userInfo){
        _userInfo = [self loadUserProfile];
    }
    return _userInfo;
}

- (YMUserInfoData*)loadUserProfile {
    YMUserInfoData *info = [[YMUserInfoData alloc] init];
    // 从文件中读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *useridKey = [defaults stringForKey:kUserInfoKey];
    if (useridKey) {
        NSString *strUserInfo = [defaults stringForKey:useridKey];
        NSDictionary *dic = [self jsonData2Dictionary: strUserInfo];
        if (dic) {
            info.token = [dic objectForKey:@"token"];
            info.userID = [dic objectForKey:@"userID"];
            info.userName = [dic objectForKey:@"name"];
            info.phone = [dic objectForKey:@"phone"];
            info.manager_id = [dic objectForKey:@"manager_id"];
            info.salon_id = [dic objectForKey:@"salon_id"];
            info.salonMapList = [dic objectForKey:@"salonMapList"];

        }
    }
    return info;
}

- (void)saveToLocal {
    // 保存昵称，头像，封页, 性别 到本地，方便其他进程读取
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:TC_PROTECT_STR(_userInfo.userID) forKey:@"userID"];
    [dic setObject:TC_PROTECT_STR(_userInfo.token) forKey:@"token"];
    [dic setObject:TC_PROTECT_STR(_userInfo.phone) forKey:@"phone"];
    [dic setObject:TC_PROTECT_STR(_userInfo.userName) forKey:@"name"];
    [dic setObject:TC_PROTECT_STR(_userInfo.manager_id) forKey:@"manager_id"];
    [dic setObject:TC_PROTECT_STR(_userInfo.salon_id) forKey:@"salon_id"];
    [dic setObject:TC_PROTECT_STR(_userInfo.salonMapList) forKey:@"salonMapList"];
    
    NSData *data = [self dictionary2JsonData: dic];
    NSString *strUserInfo = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *useridKey = [NSString stringWithFormat:@"---UserInfo"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:useridKey forKey:kUserInfoKey];
    [defaults setObject:strUserInfo forKey:useridKey];
    [defaults synchronize];
}
//发送数据JSON
- (NSData *)dictionary2JsonData:(NSDictionary *)dict
{
    // 转成Json数据
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        if(error)
        {
            NSLog(@"[%@] Post Json Error", [self class]);
        }
        return data;
    }
    else
    {
        NSLog(@"[%@] Post Json is not valid", [self class]);
    }
    return nil;
}

//接受数据解析
- (NSDictionary *)jsonData2Dictionary:(NSString *)jsonData
{
    if (jsonData == nil) {
        return nil;
    }
    NSString *str_Json = jsonData;
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\r)"
                                                   withString:@"\\\\r" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\n)"
                                                   withString:@"\\\\n" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    
    NSData *data = [str_Json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

@end
