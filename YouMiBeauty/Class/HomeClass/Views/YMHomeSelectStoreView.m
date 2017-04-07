//
//  YMHomeSelectStoreView.m
//  YouMiBeauty
//
//  Created by Soo on 2017/4/6.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMHomeSelectStoreView.h"
#import "LSHomeSelectStoreCell.h"
#import "LSHomeSelectStoreModel.h"
@interface YMHomeSelectStoreView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataArray;
@end
@implementation YMHomeSelectStoreView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:Rect(20, 0, frame.size.width-40, 40)];
        titleLabel.text = @"选择店铺";
        titleLabel.font = UIBaseFont(18);
        titleLabel.textColor = UIColorFromRGB(0x333333);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:Rect(0, 40, frame.size.width, .5)];
        lineView.backgroundColor = UIColorFromRGB(0xb2b2b2);
        [self addSubview:lineView];
        
        _tableView = [[UITableView alloc]initWithFrame:Rect(0, 40.5, frame.size.width, frame.size.height-40.5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorFromRGB(0xf0f0f0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_tableView];
    }
    return self;
}
- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)setSelectStoreDataArray:(NSArray *)selectStoreDataArray{

    [self.dataArray addObjectsFromArray:[LSHomeSelectStoreModel mj_objectArrayWithKeyValuesArray:selectStoreDataArray]];
    [_tableView reloadData];
}

#pragma Mark --- tableViewDelegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"LSHomeSelectStoreCellIdentifier";
    LSHomeSelectStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSHomeSelectStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    LSHomeSelectStoreModel *model = _dataArray[indexPath.row];
    [cell configCellWithModel:model];
    
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return W(80);
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_selectStoreBlock) {
        _selectStoreBlock(indexPath.row);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
