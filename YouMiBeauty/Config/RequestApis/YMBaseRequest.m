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
    NSString *_token;
    NSString *_manager_id;
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

-(id)requestArgument
{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    
//    // app版本
//    NSString*   app_Version =  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if (self.isUserinfo) {
        
        YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];
        
        _token      = userInfo.token;
        _manager_id = userInfo.manager_id;
        
        
        self.baseDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_token,@"token",_manager_id,@"managerId", nil];
        
        return self.baseDic;
    }
    return nil;
}

@end
