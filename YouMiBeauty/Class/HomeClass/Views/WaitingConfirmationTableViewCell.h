//
//  WaitingConfirmationTableViewCell.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/23.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingConfirmationModel.h"

@interface WaitingConfirmationTableViewCell : UITableViewCell
/**
 *  背景view
 */
@property(nonatomic,strong)UIView *backView;
/**
 *  选择按钮
 */
@property(nonatomic,strong)UIButton *selectButton;
/**
 *  头像
 */
@property(nonatomic,strong)UIImageView *headImageView;
/**
 *  名字
 */
@property(nonatomic,strong)UILabel *nameLabel;
/**
 *  描述
 */
@property(nonatomic,strong)UILabel *descriptionLabel;
/**
 *  日期
 */
@property(nonatomic,strong)UILabel *dateLabel;
/**
 *  时间
 */
@property(nonatomic,strong)UILabel *timeLabel;
/**
 *  状态
 */
@property(nonatomic,strong)UILabel *statusLabel;

@property(nonatomic,strong) NSIndexPath *indexPath;
//@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,strong) WaitingConfirmationModel *model;
@property(nonatomic,strong)void(^selectedBlock)(NSIndexPath*indexPath,BOOL isSelected,NSString *employment_userID);
- (void)setModelForCell:(WaitingConfirmationModel *)model;
- (void)setModelForCellNoBtn:(WaitingConfirmationModel *)model;
@end
