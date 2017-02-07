//
//  NSString+YMSecrityUtils.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "NSString+YMSecrityUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "Base64.h"

@implementation NSString (YMSecrityUtils)
- (NSString *)md5String
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

-(NSString *)deSecurityWithKey:(NSString *)key
{
    NSString * keyMd5 = [key md5String];
    NSData *keyData = [keyMd5 dataUsingEncoding: NSUTF8StringEncoding];
    NSUInteger keyLength = [keyData length];
    Byte * keyBytes = (Byte*)[keyData bytes];
    
    NSData * data = [Base64 decodeString:self];
    NSUInteger sourceLength = [data length];
    Byte * sourceBytes = (Byte*)[data bytes];
    Byte * resultBytes= (Byte*)malloc(sourceLength*sizeof(Byte));
    for (NSUInteger i = 0; i < sourceLength; i++) {
        Byte sByte = sourceBytes[i];
        Byte keyByte = keyBytes[i%keyLength];
        Byte resultByte = sByte - keyByte;
        resultBytes[i]=resultByte;
    }
    NSString * resultStr = [[[NSString alloc] initWithBytes:resultBytes length:sourceLength encoding:NSUTF8StringEncoding] autorelease];
    free(resultBytes);
    resultBytes = NULL;
    return resultStr;
}

-(NSString *)enSecurityWithKey:(NSString *)key
{
    NSString * keyMd5 = [key md5String];
    NSData *keyData = [keyMd5 dataUsingEncoding: NSUTF8StringEncoding];
    NSUInteger keyLength = [keyData length];
    Byte * keyBytes = (Byte*)[keyData bytes];
    
    NSData * sourceData = [self dataUsingEncoding: NSUTF8StringEncoding];
    NSUInteger sourceLength = [sourceData length];
    Byte * sourceBytes = (Byte*)[sourceData bytes];
    Byte * resultBytes= (Byte*)malloc(sourceLength*sizeof(Byte));
    for (int i = 0; i < sourceLength; i++) {
        Byte sByte = sourceBytes[i];
        Byte keyByte = keyBytes[i%keyLength];
        Byte resultByte = sByte + keyByte;
        resultBytes[i]=resultByte;
    }
    NSString * resultStr = [Base64 stringByEncodingBytes:resultBytes length:sourceLength];
    free(resultBytes);
    resultBytes = NULL;
    return resultStr;
    
}

-(NSUInteger)countOfChinese
{
    NSUInteger count = 0;
    if (self.length > 0) {
        for (NSUInteger i = 0; i<self.length; i++) {
            unichar c = [self characterAtIndex:i];
            if (c >=0x4E00 && c <=0x9FA5)
            {
                count++;
            }
        }
    }
    return count;
}

@end
