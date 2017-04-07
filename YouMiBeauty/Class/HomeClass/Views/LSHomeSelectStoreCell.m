//
//  LSHomeSelectStoreCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/4/6.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "LSHomeSelectStoreCell.h"

@implementation LSHomeSelectStoreCell

- (void)configCellWithModel:(LSHomeSelectStoreModel *)model{
    
    _detailLabel.text = model.name;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        _detailLabel = [UILabel new];
        _detailLabel.textColor = UIColorFromRGB(0x333333);
        _detailLabel.font = UIBaseFont(16);
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [_backView addSubview:_detailLabel];
        
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGB(0xb2b2b2);
        [_backView addSubview:_lineView];
    }
    return self;
}
- (void)layoutSubviews{
    
    _backView.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(W(80));
    
    _detailLabel.sd_layout
    .centerYEqualToView(_backView)
    .leftSpaceToView(_backView, 15)
    .rightSpaceToView(_backView, 15)
    .heightIs(18);
    
    _lineView.sd_layout
    .bottomEqualToView(_backView)
    .leftSpaceToView(_backView,0)
    .rightSpaceToView(_backView,0)
    .heightIs(0.5f);
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
