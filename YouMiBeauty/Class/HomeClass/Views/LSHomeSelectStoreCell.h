//
//  LSHomeSelectStoreCell.h
//  YouMiBeauty
//
//  Created by Soo on 2017/4/6.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSHomeSelectStoreModel.h"
@interface LSHomeSelectStoreCell : UITableViewCell

@property(nonatomic,strong) UIView      *backView;
@property(nonatomic,strong) UILabel     *detailLabel;
@property(nonatomic,strong) UIView      *lineView;

- (void)configCellWithModel:(LSHomeSelectStoreModel *)model;

@end
