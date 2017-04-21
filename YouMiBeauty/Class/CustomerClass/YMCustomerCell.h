//
//  YMCustomerCell.h
//  YouMiBeauty
//
//  Created by Soo on 2017/2/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCustomerModel.h"

@interface YMCustomerCell : UITableViewCell
@property(nonatomic,strong) UIView *backView;
@property(nonatomic,strong) UILabel *nameLabel;

- (void)setCellForModel:(YMCustomerModel *)model;
@end
