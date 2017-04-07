//
//  YMUserInfoMgr.h
//  YouMiBeauty
//
//  Created by Soo on 2017/3/29.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YMUserInfoData : NSObject

@property(nonatomic,strong) NSString *token;
@property(nonatomic,strong) NSString *userID;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *manager_id;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *salon_id;
@property(nonatomic,strong) NSArray *salonMapList;
@end


@interface YMUserInfoMgr : NSObject

+ (instancetype)sharedInstance;
//是否登录 YES登录，NO没登录
+ (BOOL)isLogin;

- (void)logout;

- (YMUserInfoData*)getUserProfile;  // 从内存中读取

- (YMUserInfoData*)loadUserProfile;  // 从文件中读取

- (void)setUserInfoData:(YMUserInfoData *)userInfo;

@end
