//
//  YMHomeMainCollectionViewCell.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/22.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMHomeMainCollectionViewCell : UICollectionViewCell
@property(nonatomic,assign) NSInteger selectIndex;

@property(nonatomic,weak) UIViewController *fatherVC;//务必使用weak  代理要使用弱引用，因为自定义控件是加载在视图控制器中的，视图控制器view对自定义控件是强引用，如果代理属性设置为strong，则意味着delegate对视图控制器也进行了强引用，会造成循环引用。导致控制器无法被释放，最终导致内存泄漏

@end
