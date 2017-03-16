//
//  YMHomeViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/22.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMHomeViewController.h"
//等待确认
#import "WaitingConfirmationTableViewCell.h"
#import "WaitingConfirmationModel.h"
//流水明细
#import "MonthSelectView.h"
//套餐到期
//详情
#import "YMBeautyDetailViewController.h"

#import "YMLoginViewController.h"
@interface YMHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//等待确认
@property(nonatomic,strong) UITableView         * tableView;
@property(nonatomic,strong) UITextField         * searchText;

@property(nonatomic,strong) NSMutableArray      * marksArray;
@property(nonatomic,strong) UILabel             * textLabel;
@property(nonatomic,assign) NSInteger             currentIndex;

@property(nonatomic,strong) NSMutableArray      * sectionArray;
@property(nonatomic,strong) NSMutableArray      * dataArray;//数据源
@property(nonatomic,strong) NSMutableArray      * addArray;

@property(nonatomic,assign) BOOL                  isRefresh;//是否刷新 YES是刷新，NO是加载
@property(nonatomic,assign) NSInteger             pageIndex;//分页数据

@property(nonatomic,strong) UIView              * confirmButtonView;//确认按钮
//流水明细
@property(nonatomic,strong) MonthSelectView     * monthCalenbar;
@property(nonatomic,strong) MonthSelectView     * dayCalenbar;
@property(nonatomic,strong) UILabel             * yearLabel;
@property(nonatomic,assign) NSInteger             yearNum;
@property(nonatomic,assign) NSInteger             monthNum;
@property(nonatomic,assign) NSInteger             dayNum;
//套餐到期

@end

@implementation YMHomeViewController
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    _isRefresh = YES;
}
- (NSMutableArray *)marksArray
{
    if (!_marksArray) {
        _marksArray = [NSMutableArray new];
    }
    return _marksArray;
}
- (NSMutableArray *)addArray{
    
    if (!_addArray) {
        _addArray = [NSMutableArray array];
    }
    return _addArray;
}
- (NSMutableArray *)sectionArray{
    
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
        
    }
    return _sectionArray;
}
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewNaviBar setAlpha:0];

    _pageIndex =1;
    _isRefresh = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakself = self;
    __unsafe_unretained UITableView *leftTableView = self.tableView;
    
    // 下拉刷新
    leftTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.isRefresh = YES;
        [weakself requestFromSever];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    leftTableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakself.isRefresh = NO;
        [weakself requestFromSever];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)setSelectIndex:(NSInteger)selectIndex{

    _currentIndex = selectIndex;
    if (selectIndex == 0) {
        
        _isRefresh = YES;
        
        _pageIndex =1;
        
        [self.dataArray removeAllObjects];
        
        [self.sectionArray removeAllObjects];
        
        [self setleftView];
        
        [self requestFromSever];
    }else if (selectIndex == 1){
    
        [self setMiddleView];
    }else if (selectIndex == 2){
    
        [self setRightView];
    }
}
- (UITextField *)searchText{

    if (!_searchText) {
        
        _searchText = [[UITextField alloc] initWithFrame:Rect(25, 20, SCREEN_WIDTH-50, 31)];
        _searchText.placeholder = @"搜索";
        _searchText.font = UIBaseFont(12);
        _searchText.delegate = self;
        _searchText.layer.masksToBounds = YES;
        _searchText.layer.cornerRadius = 5;
        _searchText.borderStyle = UITextBorderStyleRoundedRect;
        _searchText.clearButtonMode = UITextFieldViewModeAlways;
        _searchText.clearsOnBeginEditing = YES;
        _searchText.inputAccessoryView = [self toolBar];
        _searchText.backgroundColor = UIColorFromRGB(0xf2f2f2);

        UIImage *phoneNumImage = [UIImage imageNamed:@"icon_homesearch"];
        UIImageView * leftView = [[UIImageView alloc] initWithFrame:Rect(0, 0, 40, 31)];
        leftView.image = phoneNumImage;;
        leftView.contentMode = UIViewContentModeCenter;
        _searchText.leftViewMode = UITextFieldViewModeAlways;
        _searchText.leftView = leftView;

    }
    return _searchText;
}
- (UIView *)confirmButtonView{

    if (!_confirmButtonView) {
        
        _confirmButtonView = [[UIView alloc] initWithFrame:Rect(0, SCREEN_HEIGHT-49-W(230)-64, SCREEN_WIDTH, W(230))];
        _confirmButtonView.backgroundColor = UIColorFromRGB(0xf0f0f0);
        
        UIImage *btnImage = [UIImage imageNamed:@"icon_home_buttonpic"];
        UIButton *conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        conBtn.frame = Rect(_confirmButtonView.size.width/2-btnImage.size.width/2, _confirmButtonView.size.height/2-btnImage.size.height/2, btnImage.size.width, btnImage.size.height);
        [conBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [conBtn setTitle:@"确认" forState:UIControlStateNormal];
        [conBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButtonView addSubview:conBtn];
        
    }
    return _confirmButtonView;
}
- (void)confirmClick:(UIButton *)sender{

    NSLog(@"%@",_marksArray);
}
#pragma Mark --- 等待确认View
//等待确认
- (void)setleftView{

    [_marksArray removeAllObjects];
    [self.view addSubview:self.searchText];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.confirmButtonView];
    
}
- (UITableView *)tableView{
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 71;
    frame.size.height = SCREEN_HEIGHT-71-49-64-W(230);
    
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_currentIndex == 0) {
        
        return _sectionArray.count;
    }else if (_currentIndex == 1){
    
        return 1;
    }else if (_currentIndex == 2){
    
        return 1;
    }
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_currentIndex == 0) {
        
        return [[_sectionArray[section] valueForKey:@"datalist"] count];
    }else if (_currentIndex == 1){
        
        return _dataArray.count;
    }else if (_currentIndex == 2){
        
        return _dataArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return W(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"waitingConfirmationTableViewCellIdentifier";
    WaitingConfirmationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WaitingConfirmationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.indexPath = indexPath;
    
    WaitingConfirmationModel *model = [WaitingConfirmationModel new];
    if (_currentIndex == 0) {
        
        model = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        __weak typeof(self) weakself = self;
        cell.selectedBlock = ^(NSIndexPath * tapIndexPath,BOOL isSelected,NSString *userID){
            
            
            if (model.isSelected) {
                
                model.isSelected = NO;
                [weakself.marksArray removeObject:userID];
            }else{
                
                model.isSelected = YES;
                [weakself.marksArray addObject:userID];
            }
            
            weakself.textLabel.text = [NSString stringWithFormat:@"已选%ld人",(long)weakself.marksArray.count];
            NSLog(@"选中了 %@ 项",weakself.marksArray);
        };
        
        [cell setModelForCell:model];
    }else if (_currentIndex == 1){
    
        model = _dataArray[indexPath.row];
        [cell setModelForCellNoBtn:model];
    }else if (_currentIndex == 2){
    
        model = _dataArray[indexPath.row];
        [cell setModelForCellNoBtn:model];
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",_currentIndex);
    if (_currentIndex == 0) {
        
        YMBeautyDetailViewController *detaiVC = [YMBeautyDetailViewController new];
        [self.navigationController pushViewController:detaiVC animated:YES];
    }else if (_currentIndex == 1){
        

    }else if (_currentIndex == 2){
        

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_currentIndex == 0) {
        
        return 35.0;
    }
    return 0.001;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    WaitingConfirmationModel *model = [WaitingConfirmationModel new];
    model = [_sectionArray objectAtIndex:section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:Rect(0, 0, SCREEN_WIDTH, 35)];
    headerView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    UILabel *title = [[UILabel alloc] initWithFrame:Rect(10, 0, SCREEN_WIDTH-20, 35)];
    title.font = UIBaseFont(12);
    title.textColor = UIColorFromRGB(0x545454);
    title.text = model.groupTime;
    [headerView addSubview:title];
    
    if (_currentIndex == 0) {
        
        return headerView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}

-(void)resignFirstResponserToolbar
{
    [_searchText resignFirstResponder];
}
-(UIToolbar *)toolBar
{
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.font = UIBaseFont(14);
    [button setFrame:CGRectMake(SCREEN_WIDTH-50, 7, 50, 30)];
    button.backgroundColor = toolBar.backgroundColor;
    [button addTarget:self action:@selector(resignFirstResponserToolbar) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:button];
    
    return toolBar;
}
#pragma Mark --- 流水明细View
//流水明细
- (void)setMiddleView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *dateBackView = [[UIView alloc] initWithFrame:Rect(0, 5, SCREEN_WIDTH, 50+SCREEN_WIDTH/6+SCREEN_WIDTH/7)];
    dateBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateBackView];
    
    UIImage *btnImage = [UIImage imageNamed:@"icon_home_leftBtn"];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = Rect(15, 20, btnImage.size.width, btnImage.size.height);
    [leftBtn setBackgroundImage:btnImage forState:0];
    [leftBtn addTarget:self action:@selector(ClickToDo:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1001;
    [dateBackView addSubview:leftBtn];
    [leftBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = Rect(SCREEN_WIDTH-15-btnImage.size.width, 20, btnImage.size.width, btnImage.size.height);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_home_rightBtn"] forState:0];
    [rightBtn addTarget:self action:@selector(ClickToDo:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 1002;
    [dateBackView addSubview:rightBtn];
    [rightBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    _yearLabel = [[UILabel alloc] initWithFrame:Rect(SCREEN_WIDTH/2-50, 20, 100, 18)];
    _yearLabel.textColor = BlackTextColor;
    _yearLabel.font = UIBaseFont(16);
    _yearLabel.textAlignment = NSTextAlignmentCenter;
    [dateBackView addSubview:_yearLabel];
    _yearLabel.text = [NSString stringWithFormat:@"%ld",[self year:[NSDate date]]];
    _yearNum = [self year:[NSDate date]];
    _monthNum = [self month:[NSDate date]];
    _dayNum   = [self day:[NSDate date]];
    
    [dateBackView addSubview:self.monthCalenbar.monthSelectView];
    [dateBackView addSubview:self.dayCalenbar.monthSelectView];
    [self getYearMonthDay];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 50+SCREEN_WIDTH/6+SCREEN_WIDTH/7+10, SCREEN_WIDTH, SCREEN_HEIGHT-65-49-(50+SCREEN_WIDTH/6+SCREEN_WIDTH/7+10));
    
    [self.dataArray removeAllObjects];
    
    [self requestFromSever];
}
- (void)ClickToDo:(UIButton *)sender{

    if (sender.tag == 1001) {
        
        _yearNum -- ;
        _yearLabel.text = [NSString stringWithFormat:@"%ld",_yearNum];
    }else if (sender.tag == 1002){
    
        _yearNum ++;
        _yearLabel.text = [NSString stringWithFormat:@"%ld",_yearNum];
    }
    self.dayCalenbar.dayOfMonthNum = [self NSStringIntTeger:_monthNum andYear:self.yearNum];
    [self.dayCalenbar setData];
    [self getYearMonthDay];
}

// 今天是哪一天
- (NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}
// 这个月共有几天
- (NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}
// 本月是那一月
- (NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
// 今年是那一年
- (NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

- (MonthSelectView *)monthCalenbar{

    if (!_monthCalenbar) {
        
        _monthCalenbar = [[MonthSelectView alloc] initM_calenbarviewframe:CGRectMake(0, 50, self.view.frame.size.width, SCREEN_WIDTH/6)];
        
        _monthCalenbar.dateFrom = EDateMonth;
        
        _monthCalenbar.comp = [self month:[NSDate date]];
        
        [_monthCalenbar setData];
        
        [_monthCalenbar getdatesource];
                
        //日历背景颜色
        _monthCalenbar.McalenbarBGcolor = UIColorFromRGB(0xffffff);
        
        __weak typeof(self) weakSelf = self;
        _monthCalenbar.selectBlock = ^(NSString *date){
        
            NSLog(@"- %@",date);
            _monthNum = [date integerValue];
            weakSelf.dayCalenbar.dayOfMonthNum = [weakSelf NSStringIntTeger:[date integerValue] andYear:weakSelf.yearNum];
            [weakSelf.dayCalenbar setData];
            [weakSelf getYearMonthDay];
        };
        
    }
    return _monthCalenbar;
}
- (MonthSelectView *)dayCalenbar{
    
    if (!_dayCalenbar) {
        
        _dayCalenbar = [[MonthSelectView alloc] initM_calenbarviewframe:CGRectMake(0, 50+SCREEN_WIDTH/6, self.view.frame.size.width, SCREEN_WIDTH/7)];
        
        _dayCalenbar.dateFrom = EDateDay;
        
        _dayCalenbar.dayOfMonthNum = [self totaldaysInMonth:[NSDate date]];
        
        [_dayCalenbar setData];
        
        _dayCalenbar.comp = [self day:[NSDate date]];
        
        [_dayCalenbar getdatesource];
        
        //日历背景颜色
        _dayCalenbar.McalenbarBGcolor = UIColorFromRGB(0xffffff);
        
        __weak typeof(self) weakSelf = self;
        _dayCalenbar.selectBlock = ^(NSString *date){
            
            NSLog(@"- %@",date);
            _dayNum = [date integerValue];
            [weakSelf getYearMonthDay];
        };
        
    }
    return _dayCalenbar;
}

/**
 *  判断一个月有多少天
 *
 *  @param date 日期
 *
 *  @return
 */

- (NSInteger)NSStringIntTeger:(NSInteger)teger andYear:(NSInteger)year

{
    
    NSInteger dayCount;
    
    switch (teger) {
            
        case 1:
            
            dayCount = 31;
            
            break;
            
        case 2:
            
            if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
                
                dayCount = 29;
                
            }else{
                
                dayCount = 28;
                
            }
            
            break;
            
        case 3:
            
            dayCount = 31;
            
            break;
            
        case 4:
            
            dayCount = 30;
            
            break;
            
        case 5:
            
            dayCount = 31;
            
            break;
            
        case 6:
            
            dayCount = 30;
            
            break;
            
        case 7:
            
            dayCount = 31;
            
            break;
            
        case 8:
            
            dayCount = 31;
            
            break;
            
        case 9:
            
            dayCount = 30;
            
            break;
            
        case 10:
            
            dayCount = 31;
            
            break;
            
        case 11:
            
            dayCount = 30;
            
            break;
            
        default:
            
            dayCount = 31;
            
            break;
            
    }
    
    return dayCount;
}
- (void)getYearMonthDay{

    NSLog(@"date --- %ld-%ld-%ld",_yearNum,_monthNum,_dayNum);
}
#pragma Mark --- 套餐到期View
//套餐到期
- (void)setRightView{

    [self.view addSubview:self.searchText];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = Rect(0, 71, SCREEN_WIDTH, SCREEN_HEIGHT-65-71-49);
    [self.dataArray removeAllObjects];
    
    [self requestFromSever];
}

- (void)requestFromSever{

    NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:@{@"userID":@"1",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"2",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"3",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"4",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"5",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"6",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"十月"},@{@"userID":@"7",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"8",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"9",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"九月"},@{@"userID":@"10",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"11",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"十月"},@{@"userID":@"12",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"13",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"14",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"15",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"九月"}, nil];
    
    
    if (_currentIndex == 0) {
        
        __weak typeof(self) weakself = self;
        
        NSArray *pbaseArr = dataArray;
        
        NSMutableArray *addTempArray = [NSMutableArray array];
        if (weakself.isRefresh) {
            
            addTempArray = dataArray;
            [weakself.addArray removeAllObjects];
            [weakself.addArray addObjectsFromArray:pbaseArr];
        }else{
            
            [weakself.marksArray removeAllObjects];
            [weakself.addArray addObjectsFromArray:pbaseArr];
            [addTempArray addObjectsFromArray:weakself.addArray];
        }
        
        NSMutableArray *dataArr = [NSMutableArray array];
        
        for (int j = 0; j < addTempArray.count; j++) {
            
            NSString *title = [addTempArray[j] objectForKey:@"groupTime"];
            
            NSMutableArray *datalist = [@[] mutableCopy];
            
            NSMutableDictionary *dataDic = [@{} mutableCopy];
            
            [datalist addObject:addTempArray[j]];
            
            for (int k = j+1; k < addTempArray.count; k ++) {
                
                if ([title isEqualToString:[addTempArray[k] objectForKey:@"groupTime"]]) {
                    
                    [datalist addObject:addTempArray[k]];
                    
                    [addTempArray removeObjectAtIndex:k];
                    
                    k = k-1;
                }
                
            }
            
            [dataDic setObject:title forKey:@"groupTime"];
            [dataDic setObject:datalist forKey:@"datalist"];
            [dataArr addObject:dataDic];
            
        }
        
        [weakself.sectionArray removeAllObjects];
        [weakself.dataArray removeAllObjects];
        
        if (weakself.isRefresh) {
            
            [weakself.tableView.mj_header endRefreshing];
        }else{
            
            
            if ([(NSArray *)dataArray count] == 0) {
                
                [weakself showMBHud:@"暂无更多数据！"];
            }
            [weakself.tableView.mj_footer endRefreshing];
        }
        
        [weakself.sectionArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArr]];
        
        NSArray *tempArray = [[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArr] valueForKey:@"datalist"];
        
        [weakself.dataArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:tempArray]];
        
        if (weakself.dataArray.count == 0) {
            
            //        weakself.noConnectionView = [[LQNoInternetConnection alloc]initWithFrame:Rect(0, ViewBavBarH+45, SCREEN_WIDTH, SCREEN_HEIGHT) andType:NO];
            //
            //        [weakself.view addSubview:weakself.noConnectionView];
        }
        [weakself.tableView reloadData];
    }else if (_currentIndex == 1){
    
        if (self.isRefresh) {
            
            [self.tableView.mj_header endRefreshing];
        }else{
            
            [self.tableView.mj_footer endRefreshing];
        }
        [self.dataArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArray]];
    }else if (_currentIndex == 2){
    
        [self.dataArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArray]];
        if (self.isRefresh) {
            
            [self.tableView.mj_header endRefreshing];
        }else{
            
            [self.tableView.mj_footer endRefreshing];
        }
    }
    
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
