//
//  YMNoInternetConnection.m
//  YouMiBeauty
//
//  Created by Soo on 2017/4/20.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMNoInternetConnection.h"

/**
 *  断开网络,没有数据时显示的界面
 */
@interface YMNoInternetConnection ()
//可点击-重新刷新
@property(nonatomic,strong) UIButton *clickButton;
@property(nonatomic,strong) UIImageView * errorImageView;
@property(nonatomic,strong) UILabel * errorLabel;
@end

@implementation YMNoInternetConnection

- (instancetype)initWithFrame:(CGRect)frame andType:(NoDataAndNoInternet)noConOrnoData
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _noConOrnoData = noConOrnoData;
        
        _errorImageView = [[UIImageView alloc] init];
        [self addSubview:_errorImageView];
        
        _errorLabel = [[UILabel alloc] init];
        [self addSubview:_errorLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [button addTarget:self action:@selector(clickToDo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _clickButton = button;
        
        if (noConOrnoData == EFNoInternet){
            [self noInterNetStatus];
        }else if (noConOrnoData == EFNoData){
            [self noDataStatus];
        }
        
    }
    return self;
}

-(void)setNoConOrnoData:(NoDataAndNoInternet)noConOrnoData
{
    if (_noConOrnoData == noConOrnoData) {
        return;
    }
    _noConOrnoData = noConOrnoData;
    self.clickButton.userInteractionEnabled = YES;
    if (noConOrnoData == EFNoInternet){
        
        [self noInterNetStatus];
        
    }else if (noConOrnoData == EFNoData){
        
        [self noDataStatus];
    }
}

-(void)noInterNetStatus
{
    UIImage *hintImage = [UIImage imageNamed:@"noInternetConnection"];
    [self.errorImageView setFrame:CGRectMake(SCREEN_WIDTH/2-hintImage.size.width/2, W(240), hintImage.size.width, hintImage.size.height)];
    [self.errorImageView setImage:hintImage];
    
    [self.errorLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.errorImageView.frame)+12, SCREEN_WIDTH, 16)];
    self.errorLabel.text = @"网络去偷懒了~点击刷新";
    self.errorLabel.textColor = UIColorFromRGB(0xe0e0e0);
    self.errorLabel.font = UIBaseFont(16);
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.clickButton.userInteractionEnabled = YES;
}

-(void)noDataStatus
{
    UIImage *hintImage = [UIImage imageNamed:@"noMessage"];
    [self.errorImageView setFrame:CGRectMake(SCREEN_WIDTH/2-hintImage.size.width/2, W(204), hintImage.size.width, hintImage.size.height)];
    [self.errorImageView setImage:hintImage];
    
    [self.errorLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.errorImageView.frame)+12, SCREEN_WIDTH, 24)];
    self.errorLabel.text = @"暂无内容";
    self.errorLabel.textColor = UIColorFromRGB(0x666666);
    self.errorLabel.font = UIBaseFont(24);
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.clickButton.userInteractionEnabled = NO;
}

- (void)clickToDo{
    
    if (self.clickBlock) {
        self.clickBlock();
    }
    
}
- (void)hiddenNoConnectionView{
    
    [self removeFromSuperview];
}

- (void)dealloc
{
    _clickBlock=nil;
}

@end
