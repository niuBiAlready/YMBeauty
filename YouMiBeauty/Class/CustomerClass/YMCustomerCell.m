//
//  YMCustomerCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/2/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMCustomerCell.h"

@implementation YMCustomerCell
- (void)setCellForModel:(YMCustomerModel *)model {
    
    _nameLabel.text = model.name;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backView = [UIView new];
        _backView.backgroundColor = UIColorFromRGB(0xffffff);
        [self addSubview:_backView];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = UIBaseFont(14);
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        [_backView addSubview:_nameLabel];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _backView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(50);
    
    _nameLabel.sd_layout
    .centerYEqualToView(_backView)
    .leftSpaceToView(_backView,LeftRange)
    .widthIs(SCREEN_WIDTH-3*LeftRange-30)
    .heightIs(50);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
