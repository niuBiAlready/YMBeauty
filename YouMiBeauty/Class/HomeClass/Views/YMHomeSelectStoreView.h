//
//  YMHomeSelectStoreView.h
//  YouMiBeauty
//
//  Created by Soo on 2017/4/6.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMHomeSelectStoreView : UIView

@property(nonatomic,strong) NSArray *selectStoreDataArray;

@property(nonatomic,copy) void(^selectStoreBlock)(NSInteger index);
@end
