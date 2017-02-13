//
//  YMBeautyDetailCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/2/12.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBeautyDetailCell.h"

@implementation YMBeautyDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)layoutSubviews{

    
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
