//
//  NSString+YMSecrityUtils.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YMSecrityUtils)
-(NSString *)md5String;
-(NSString *)enSecurityWithKey:(NSString *)key;
-(NSString *)deSecurityWithKey:(NSString *)key;
-(NSUInteger)countOfChinese;
@end
