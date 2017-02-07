//
//  YMRootViewController.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMRootViewController : UITabBarController
-(void)setSelectedIndexFromWithIndex:(NSInteger )index;
-(void)remoteNotificationjumpToVC:(NSInteger)type webUrl:(NSString*)pageurl guanlianID:(NSString*)guanlianid secondID:(NSString*)secondid islogin:(NSString*) islogin;
@end
