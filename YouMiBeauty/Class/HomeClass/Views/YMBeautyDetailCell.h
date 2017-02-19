//
//  YMBeautyDetailCell.h
//  YouMiBeauty
//
//  Created by Soo on 2017/2/12.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMBeautyDetailCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *detailLabel;

- (void)configCellWithModel:(id)model;
@end
