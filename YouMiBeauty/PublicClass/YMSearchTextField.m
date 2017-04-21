//
//  YMSearchTextField.m
//  YouMiBeauty
//
//  Created by Soo on 2017/4/20.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMSearchTextField.h"

@interface YMSearchTextField ()<UITextFieldDelegate>


@end

@implementation YMSearchTextField

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _searchText = [[UITextField alloc] initWithFrame:Rect(25, 20, SCREEN_WIDTH-50, 31)];
        _searchText.font = UIBaseFont(12);
        _searchText.delegate = self;
        _searchText.layer.masksToBounds = YES;
        _searchText.layer.cornerRadius = 5;
        _searchText.borderStyle = UITextBorderStyleRoundedRect;
        _searchText.clearButtonMode = UITextFieldViewModeAlways;
        _searchText.clearsOnBeginEditing = YES;
        _searchText.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [_searchText addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        UIImage *phoneNumImage = [UIImage imageNamed:@"icon_homesearch"];
        UIImageView * leftView = [[UIImageView alloc] initWithFrame:Rect(0, 0, 40, 31)];
        leftView.image = phoneNumImage;;
        leftView.contentMode = UIViewContentModeCenter;
        _searchText.leftViewMode = UITextFieldViewModeAlways;
        _searchText.leftView = leftView;
        
        [self addSubview:_searchText];
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = Rect(SCREEN_WIDTH-45, 20, 35, 31);
        _searchBtn.titleLabel.font = UIBaseFont(16);
        [_searchBtn setTitle:@"搜索" forState:0];
        [_searchBtn setTitleColor:PinkTextColor forState:0];
        [_searchBtn addTarget:self  action:@selector(ClickToDo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchBtn];
        _searchBtn.hidden = YES;
    }
    return self;
}
-(void)valueChanged:(UITextField*)textField{

    if (textField.text.length == 0) {
        
        if (_searchAction) {
            _searchAction(@"");
        }
    }
    
}
- (void)ClickToDo:(UIButton *)sender{

    [_searchText resignFirstResponder];
    if (_searchAction) {
        _searchAction(_searchText.text);
    }
}
- (void)setPlaceholderText:(NSString *)placeholderText{

    _searchText.placeholder = placeholderText;
}

@end
