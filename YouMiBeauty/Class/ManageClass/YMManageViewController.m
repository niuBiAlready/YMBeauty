//
//  YMManageViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMManageViewController.h"
#import "YMManagerViewCell.h"

#define CellString @"YMManagerViewCell"

@interface YMManageViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic, strong) UITableView * tableView;

@property(nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation YMManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewNaviBar setAlpha:0];
    [self configUI];
    
    
    // Do any additional setup after loading the view.
}


- (void)configUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:(UITableViewStylePlain)];
    [self.tableView registerClass:[YMManagerViewCell class] forCellReuseIdentifier:CellString];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTableFooterView:[UIView new]];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMManagerViewCell *cell;
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellString];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
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
