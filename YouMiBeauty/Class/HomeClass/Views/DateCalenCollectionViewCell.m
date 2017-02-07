//
//  DateCalenCollectionViewCell.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/24.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "DateCalenCollectionViewCell.h"


@implementation DateCalenCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.monthNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.monthNumBtn.frame = Rect(0, 0, SCREEN_WIDTH/6-10, SCREEN_WIDTH/6-10);
        self.monthNumBtn.center = self.contentView.center;
        self.monthNumBtn.titleLabel.font = UIBaseFont(14);
        [self.monthNumBtn setTitleColor:[UIColor blackColor] forState:0];
        self.monthNumBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:self.monthNumBtn];
    }
    return self;
}


//月模式

- (void)MonthLabel:(NSIndexPath *)indexPath comp:(NSInteger )comp number:(NSString *)num fromType:(NSInteger)type
{

    
    [self.monthNumBtn setTitle:num forState:0];
    if (type == 0) {
        
        [self.monthNumBtn setBackgroundImage:[UIImage imageNamed:@"month_select"] forState:1];
        [self.monthNumBtn setBackgroundImage:nil forState:0];
        if ((indexPath.row + 1) == comp) {
            
            [self.monthNumBtn setBackgroundImage:[UIImage imageNamed:@"month_select"] forState:0];
            [self.monthNumBtn setTitleColor:[UIColor whiteColor] forState:0];
            
        }else{
        
            [self.monthNumBtn setBackgroundImage:nil forState:0];
            [self.monthNumBtn setTitleColor:[UIColor blackColor] forState:0];
        }
    }else{
    
        [self.monthNumBtn setBackgroundImage:[UIImage imageNamed:@"day_select"] forState:1];
        [self.monthNumBtn setBackgroundImage:nil forState:0];
        if ((indexPath.row + 1) == comp) {
            
            [self.monthNumBtn setBackgroundImage:[UIImage imageNamed:@"day_select"] forState:0];
            [self.monthNumBtn setTitleColor:[UIColor whiteColor] forState:0];
            
        }else{
            
            [self.monthNumBtn setBackgroundImage:nil forState:0];
            [self.monthNumBtn setTitleColor:[UIColor blackColor] forState:0];
        }
    }
    
}

@end

