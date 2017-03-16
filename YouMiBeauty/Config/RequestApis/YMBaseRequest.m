//
//  YMBaseRequest.m
//  YouMiBeauty
//
//  Created by Soo on 2017/3/10.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseRequest.h"

@implementation YMBaseRequest
{
    NSString *_userid;
    NSString *_token;
}
-(id)init
{
    self =[super init];
    if (self) {
        _baseDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}
- (NSString *)baseUrl {
    
    return ServerURL;//正式api
    
}
- (id)responseJSONObject {
    
    if (self.isSecurity) {
        NSString * securityString = [self.requestOperation.responseObject objectForKey:@"safejson"];
        
        
        return [self deSecurityMethod:securityString] ;
    }
    //     [self saveJsonResponseToCacheFile:self.requestOperation.responseObject];
    return self.requestOperation.responseObject;
}
-(id)deSecurityMethod:(NSString*)security
{
    NSString * res = [security deSecurityWithKey:kSecurityXiaoMiKey];
    return  [self dictionaryWithJsonString:res];
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    //    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //    NSError *err;
    //    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
    //                                                        options:NSJSONReadingMutableContainers
    //                                                          error:&err];
    NSString *str_Json = jsonString;
    //    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"    " withString:@""];
    //    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\\\\)"
    //                                                   withString:@"\\\\\\\\" options:NSRegularExpressionSearch
    //                                                        range:NSMakeRange(0, [str_Json length])];
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\r)"
                                                   withString:@"\\\\r" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\n)"
                                                   withString:@"\\\\n" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    
    NSData *jsonData = [str_Json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    //       baseDic = [NSDictionary dictionaryWithDictionary:dic];
    return dic;
}
//-(void)savecacheData
//{
//      [self saveJsonResponseToCacheFile:baseDic];
//}
//-(id)readCacheData
//{
//    return [self cacheSensitiveData];
//}
//-(id)cacheJson
//{
//
//}
//-(id)cacheSensitiveData
//{
//    return baseDic;
//}
-(id)requestArgument
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // app版本
    NSString*   app_Version =  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if (self.isUserinfo) {
        
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        
        _userid     = [userInfo objectForKey:@"userid"];
        _token      = [userInfo objectForKey:@"token"];
        
        
        self.baseDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:  _userid,@"userid",
                        _token,@"token",
                        @"ios",@"tagfrom",app_Version,@"version", nil];
        
        return self.baseDic;
    }
    return nil;
}

@end
