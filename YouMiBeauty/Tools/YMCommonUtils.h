//
//  YMCommonUtils.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMCommonUtils : NSObject
/**
 *  电话直接拨打
 *
 *  @param phone
 */
+(void)callTelphoneNum:(NSString*)phone;
/**
 *  色值转图片
 */
+ (UIImage*) createImageWithColor: (UIColor*) color;
/**
 *  身份证正则
 */
+(BOOL)verifyIDCardNumber:(NSString*)value;
+ (BOOL) checkCardNo:(NSString*) cardNo;

+ (NSString *)returnBankName:(NSString*) idCard;
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;

+(NSDictionary*)securityMethod:(NSDictionary *)dic isSecurity:(BOOL)security;
+(NSMutableAttributedString *)parseSpanString:(NSString*)string withSpanStartStr:(NSString*)spanStart spanEndStr:(NSString*)spanEnd spanColor:(UIColor*)color;

+(BOOL)checkIsNotFirstLaunch;
@end
