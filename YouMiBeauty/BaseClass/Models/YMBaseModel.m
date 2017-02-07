//
//  YMBaseModel.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/23.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseModel.h"

@implementation YMBaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}
+ (instancetype)initWithKVCDictionary:(NSDictionary *)KVCDic{
    
    return [[[self class] alloc] initWithDictionary:KVCDic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (void)setNilValueForKey:(NSString *)key{
    
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return  nil;
}
@end
