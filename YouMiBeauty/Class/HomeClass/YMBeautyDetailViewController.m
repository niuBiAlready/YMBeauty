//
//  YMBeautyDetailViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/2/12.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBeautyDetailViewController.h"
#import "YMBeautyDetailCell.h"

@interface YMBeautyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView         * tableView;
@property(nonatomic,strong) NSMutableArray      * dataArray;//数据源

@end

@implementation YMBeautyDetailViewController
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewNaviBar setTitle:@"记录详情"];
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(UITableView*)tableView
{
    CGRect frame = self.view.bounds;
    frame.origin.y = NavBarHeight;
    frame.size.height = SCREEN_HEIGHT-NavBarHeight;
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        
    }
    return _tableView;
}

#pragma tableViewDelegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"beautyDetailCellIdentifier";
    YMBeautyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YMBeautyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellWithModel:ID];
    
    return cell;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
