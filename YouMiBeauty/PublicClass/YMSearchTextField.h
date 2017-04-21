//
//  YMSearchTextField.h
//  YouMiBeauty
//
//  Created by Soo on 2017/4/20.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMSearchTextField : UIView

@property(nonatomic,strong) UITextField         * searchText;
@property(nonatomic,copy)   NSString            *placeholderText;
@property(nonatomic,strong) UIButton            *searchBtn;
@property(nonatomic,copy)   void(^searchAction)(NSString *searchText);
@end
