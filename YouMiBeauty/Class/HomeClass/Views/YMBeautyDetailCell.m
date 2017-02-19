//
//  YMBeautyDetailCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/2/12.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBeautyDetailCell.h"

@implementation YMBeautyDetailCell

- (void)configCellWithModel:(id)model{

    _titleLabel.text = @"名字";
    _detailLabel.text = @"大黄";
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        _titleLabel.font = UIBaseFont(14);
        [self.contentView addSubview:_titleLabel];
        
        
        _detailLabel = [UILabel new];
        _detailLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.font = UIBaseFont(14);
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_detailLabel];
        
    }
    return self;
}
- (void)layoutSubviews{

    _titleLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH/2-10)
    .heightIs(14);
    
    _detailLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,10)
    .widthIs(SCREEN_WIDTH/2-10)
    .heightIs(14);
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
