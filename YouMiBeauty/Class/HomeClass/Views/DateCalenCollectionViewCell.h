//
//  DateCalenCollectionViewCell.h
//  YouMiBeauty
//
//  Created by Soo on 2017/1/24.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCalenCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong)UIButton * monthNumBtn;

//以下是月模式
- (void)MonthLabel:(NSIndexPath *)indexPath comp:(NSInteger )comp number:(NSString *)num fromType:(NSInteger)type;


@end

