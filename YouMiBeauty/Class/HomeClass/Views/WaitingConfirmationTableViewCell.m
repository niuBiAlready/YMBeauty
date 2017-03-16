//
//  WaitingConfirmationTableViewCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/23.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "WaitingConfirmationTableViewCell.h"

@implementation WaitingConfirmationTableViewCell


- (void)setModelForCell:(WaitingConfirmationModel *)model{

    _model = model;
    _selectButton.selected = model.isSelected;
    _nameLabel.text = model.name;
    _descriptionLabel.text = model.descriptionText;
    _dateLabel.text = model.date;
    _timeLabel.text = model.time;
    _statusLabel.text = model.status;
    [self setSubViews];
}
-(void)setModelForCellNoBtn:(WaitingConfirmationModel *)model{

    _nameLabel.text = model.name;
    _descriptionLabel.text = model.descriptionText;
    _dateLabel.text = model.date;
    _timeLabel.text = model.time;
    _statusLabel.text = model.status;
    
    [self setNoBtnSubViews];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = UIColorFromRGB(0xffffff);
        [self addSubview:_backView];
        
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"icon_home_checkBox_normal"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"icon_home_checkBox_press"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(clickForSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_selectButton];
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        [_backView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = BlackTextColor;
        _nameLabel.font = UIBaseFont(16);
        [_backView addSubview:_nameLabel];
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = DarkTextColor;
        _descriptionLabel.font = UIBaseFont(14);
        [_backView addSubview:_descriptionLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = GrayTextColor;
        _dateLabel.font = UIBaseFont(14);
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        [_backView addSubview:_dateLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = GrayTextColor;
        _timeLabel.font = UIBaseFont(14);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_backView addSubview:_timeLabel];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.backgroundColor = [UIColor greenColor];
        _statusLabel.font = UIBaseFont(12);
        _statusLabel.layer.cornerRadius = 6;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_statusLabel];
    }
    return self;
}
//没有按钮
- (void)setNoBtnSubViews{
    
    _backView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(W(130));
    
    _dateLabel.adjustsFontSizeToFitWidth = YES;
    _dateLabel.sd_layout
    .bottomSpaceToView(_backView,W(130)/2+5)
    .leftSpaceToView(_backView,LeftRange)
    .widthIs(14*3)
    .heightIs(14);
    
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.sd_layout
    .topSpaceToView(_backView,W(130)/2+5)
    .leftSpaceToView(_backView,LeftRange)
    .widthIs(14*3)
    .heightIs(14);
    
    UIImage *headerImage = [UIImage imageNamed:@"icon_home_customerpic"];
    [_headImageView setImage:headerImage];
    _headImageView.layer.cornerRadius = W(40);
    _headImageView.sd_layout
    .centerYEqualToView(_backView)
    .leftSpaceToView(_dateLabel,LeftRange)
    .widthIs(W(80))
    .heightIs(W(80));
    
    _statusLabel.sd_layout
    .topSpaceToView(_backView,W(30))
    .rightSpaceToView(_backView,LeftRange)
    .widthIs(12*5)
    .heightIs(14);
    
    _nameLabel.sd_layout
    .bottomSpaceToView(_backView,W(130)/2+5)
    .leftSpaceToView(_headImageView,LeftRange)
    .rightSpaceToView(_statusLabel,5)
    .heightIs(16);
    
    _descriptionLabel.adjustsFontSizeToFitWidth = YES;
    _descriptionLabel.sd_layout
    .topSpaceToView(_backView,W(130)/2+5)
    .leftEqualToView(_nameLabel)
    .rightSpaceToView(_backView,LeftRange)
    .heightIs(14);
}
//有按钮
- (void)setSubViews{

    _backView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(W(130));
    
    UIImage *selectBtnImg = [UIImage imageNamed:@"icon_home_checkBox_press"];;
    _selectButton.sd_layout
    .centerYEqualToView(_backView)
    .leftSpaceToView(_backView,LeftRange)
    .widthIs(selectBtnImg.size.width)
    .heightIs(selectBtnImg.size.height);
    
    _dateLabel.adjustsFontSizeToFitWidth = YES;
    _dateLabel.sd_layout
    .bottomSpaceToView(_backView,W(130)/2+5)
    .leftSpaceToView(_selectButton,LeftRange)
    .widthIs(14*3)
    .heightIs(14);
    
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.sd_layout
    .topSpaceToView(_backView,W(130)/2+5)
    .leftSpaceToView(_selectButton,LeftRange)
    .widthIs(14*3)
    .heightIs(14);
    
    UIImage *headerImage = [UIImage imageNamed:@"icon_home_customerpic"];
    [_headImageView setImage:headerImage];
    _headImageView.layer.cornerRadius = W(40);
    _headImageView.sd_layout
    .centerYEqualToView(_backView)
    .leftSpaceToView(_dateLabel,LeftRange)
    .widthIs(W(80))
    .heightIs(W(80));
    
    _statusLabel.sd_layout
    .topSpaceToView(_backView,W(30))
    .rightSpaceToView(_backView,LeftRange)
    .widthIs(12*5)
    .heightIs(14);
    
    _nameLabel.sd_layout
    .bottomSpaceToView(_backView,W(130)/2+5)
    .leftSpaceToView(_headImageView,LeftRange)
    .rightSpaceToView(_statusLabel,5)
    .heightIs(16);
    
    _descriptionLabel.adjustsFontSizeToFitWidth = YES;
    _descriptionLabel.sd_layout
    .topSpaceToView(_backView,W(130)/2+5)
    .leftEqualToView(_nameLabel)
    .rightSpaceToView(_backView,LeftRange)
    .heightIs(14);
}
- (void)setIndex:(NSIndexPath *)index{
    
    _indexPath = index;
}

//- (void)setIsSelected:(BOOL)isSelected{
//    
//    _selectButton.selected = isSelected;
//}
- (void)clickForSelected:(UIButton *)button{
    
    button.selected = !button.selected;
    if (_selectedBlock && _indexPath) {
        _selectedBlock(_indexPath,button.isSelected,_model.userID);
    }
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
