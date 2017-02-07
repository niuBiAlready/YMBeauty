//
//  YMBaseModel.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/23.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMBaseModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end
