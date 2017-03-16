//
//  YMBaseRequest.h
//  YouMiBeauty
//
//  Created by Soo on 2017/3/10.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface YMBaseRequest : YTKRequest
@property(nonatomic,strong)NSMutableDictionary *baseDic;
@property(nonatomic,assign)BOOL isUserinfo;//是否需要用户token
@property(nonatomic,assign)BOOL isSecurity;//是否加密解密
@end
