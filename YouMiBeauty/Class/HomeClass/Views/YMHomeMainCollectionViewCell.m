//
//  YMHomeMainCollectionViewCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/22.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMHomeMainCollectionViewCell.h"
#import "YMHomeViewController.h"

@interface YMHomeMainCollectionViewCell()
@property(nonatomic,strong) YMHomeViewController *homeViewController;
@end
@implementation YMHomeMainCollectionViewCell
- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        self.homeViewController = [YMHomeViewController new];
        
        [self.contentView addSubview:self.homeViewController.view];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.fatherVC addChildViewController:self.homeViewController];
    
    self.homeViewController.view.frame = self.bounds;
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    
    self.homeViewController.selectIndex = selectIndex;
}

@end
