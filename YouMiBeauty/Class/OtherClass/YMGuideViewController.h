//
//  YMGuideViewController.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMGuideViewController;

@protocol YMGuideViewControllerDelegate <NSObject>

-(void)guideDoneToShowApp:(YMGuideViewController *)controller imageView:(UIImageView*)image;

@end

@interface YMGuideViewController : UIViewController
@property(nonatomic,weak) id<YMGuideViewControllerDelegate>delegate;
@end
