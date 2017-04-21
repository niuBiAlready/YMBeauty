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

    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
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

    _selectIndex = selectIndex;
    [_searchText resignFirstResponder];
    NSLog(@"selectIndex --- %ld",selectIndex);
    if (selectIndex == 0) {
        
        _isRefresh = YES;
        
        _pageIndex =1;
        
        [self.dataArray removeAllObjects];
        
        [self.sectionArray removeAllObjects];
        
        [self setleftView];
        
        [self requestFromSever];
    }else if (selectIndex == 1){
    
        _isRefresh = YES;
        
        _pageIndex =1;
        
        [self.dataArray removeAllObjects];
        
        [self.sectionArray removeAllObjects];
        
        [self setMiddleView];
        
        [self requestFromSever];
        
        
    }else if (selectIndex == 2){
    
        _isRefresh = YES;
        
        _pageIndex =1;
        
        [self.dataArray removeAllObjects];
        
        [self.sectionArray removeAllObjects];
        
        [self requestFromSever];
        
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
    
    if (_selectIndex == 0) {
        
        return _sectionArray.count;
    }else if (_selectIndex == 1){
    
//        return 1;
        return _sectionArray.count;
    }else if (_selectIndex == 2){
    
//        return 1;
        return _sectionArray.count;
    }
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_selectIndex == 0) {
        
        return [[_sectionArray[section] valueForKey:@"datalist"] count];
    }else if (_selectIndex == 1){
        
//        return _dataArray.count;
        return [[_sectionArray[section] valueForKey:@"datalist"] count];
    }else if (_selectIndex == 2){
        
//        return _dataArray.count;
        return [[_sectionArray[section] valueForKey:@"datalist"] count];
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
    if (_selectIndex == 0) {
        
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
    }else if (_selectIndex == 1){
    
//        model = _dataArray[indexPath.row];
        model = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [cell setModelForCellNoBtn:model];
    }else if (_selectIndex == 2){
    
//        model = _dataArray[indexPath.row];
        model = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [cell setModelForCellNoBtn:model];
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",_selectIndex);
    if (_selectIndex == 0) {
        
        YMBeautyDetailViewController *detaiVC = [YMBeautyDetailViewController new];
        [self.navigationController pushViewController:detaiVC animated:YES];
    }else if (_selectIndex == 1){
        

    }else if (_selectIndex == 2){
        

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_selectIndex == 0) {
        
        return 35.0;
    }
    return 0.001;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_selectIndex == 0) {
        WaitingConfirmationModel *model = [WaitingConfirmationModel new];
        model = [_sectionArray objectAtIndex:section];
        
        UIView *headerView = [[UIView alloc] initWithFrame:Rect(0, 0, SCREEN_WIDTH, 35)];
        headerView.backgroundColor = UIColorFromRGB(0xf0f0f0);
        
        UILabel *title = [[UILabel alloc] initWithFrame:Rect(10, 0, SCREEN_WIDTH-20, 35)];
        title.font = UIBaseFont(12);
        title.textColor = UIColorFromRGB(0x545454);
        title.text = model.groupTime;
        [headerView addSubview:title];
        return headerView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
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
    [self requestFromSever];
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
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
- (void)changeTime:(NSString *)timeString result:(void(^)(NSString*date,NSString *year,NSString *month,NSString*day,NSString*time))result{

    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    //年月日
    [formatter setDateFormat:@"yyyy年MM月"];
    NSString* dateString = [formatter stringFromDate:date];
    //年
    [formatter setDateFormat:@"yyyy"];
    NSString* dateStringYear = [formatter stringFromDate:date];
    //月
    [formatter setDateFormat:@"MM"];
    NSString* dateStringMonth = [formatter stringFromDate:date];
    //日
    [formatter setDateFormat:@"dd"];
    NSString* dateStringDay = [formatter stringFromDate:date];
    //时间
    [formatter setDateFormat:@"HH:mm"];
    NSString* dateStringtime = [formatter stringFromDate:date];
    
    result(dateString,dateStringYear,dateStringMonth,dateStringDay,dateStringtime);
}
- (void)requestFromSever{

    
    if (_isRefresh) {
        
        _pageIndex = 1;
    }else{
    
        _pageIndex ++;
    }
    __weak typeof(self) weakself = self;
    
//    [self showSenderToServer:@""];

    
    if (_selectIndex == 0) {
        
        YMHomeWaitingForConfirmationAPI *waitingForConfirmation = [[YMHomeWaitingForConfirmationAPI alloc] initStatus:@"1" andPage:_pageIndex];
        
        [waitingForConfirmation startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            
            [weakself hiddenMBHud];
            [weakself.noConnectionView hiddenNoConnectionView];
            //        NSLog(@"data --- %@",request.responseJSONObject);
            NSArray * tempArr = [request.responseJSONObject objectForKey:@"data"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (int i = 0; i<tempArr.count; i ++) {
                
                NSDictionary *tempDic = tempArr[i];
                NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
                
                [tempDictionary setObject:tempDic[@"ref_id"] forKey:@"ref_id"];
                [tempDictionary setObject:tempDic[@"salon_id"] forKey:@"salon_id"];
                [tempDictionary setObject:tempDic[@"insert_time"] forKey:@"insert_time"];
                [tempDictionary setObject:tempDic[@"type"] forKey:@"type"];
                [tempDictionary setObject:tempDic[@"manager_id"] forKey:@"manager_id"];
                [tempDictionary setObject:tempDic[@"customer_tip"] forKey:@"customer_tip"];
                [tempDictionary setObject:tempDic[@"expire"] forKey:@"expire"];
                [tempDictionary setObject:tempDic[@"name"] forKey:@"name"];
                [tempDictionary setObject:tempDic[@"id"] forKey:@"id"];
                [tempDictionary setObject:tempDic[@"customer_name"] forKey:@"customer_name"];
                [tempDictionary setObject:tempDic[@"detail"] forKey:@"detail"];
                [tempDictionary setObject:tempDic[@"customer_id"] forKey:@"customer_id"];
                [tempDictionary setObject:tempDic[@"status"] forKey:@"status"];
                
                NSString *timeString = [tempArr[i] objectForKey:@"insert_time"];
                
                [weakself changeTime:timeString result:^(NSString*date, NSString *year, NSString *month, NSString *day, NSString*time) {
                    
                    //                NSLog(@"date - %@,time === %@ - %@ - %@ - %@",date,year,month,day,time);
                    [tempDictionary setObject:date forKey:@"groupTime"];
                    [tempDictionary setObject:date forKey:@"date"];
                    [tempDictionary setObject:year forKey:@"year"];
                    [tempDictionary setObject:month forKey:@"month"];
                    [tempDictionary setObject:day forKey:@"day"];
                    [tempDictionary setObject:time forKey:@"time"];
                    
                }];
                
                [dataArray addObject:tempDictionary];
                
            }
            [weakself showMBHud:request.responseJSONObject[@"msg"]];
            
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
                
                weakself.noConnectionView = [[YMNoInternetConnection alloc]initWithFrame:Rect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) andType:NO];
                
                [weakself.view addSubview:weakself.noConnectionView];
            }
            [weakself.tableView reloadData];
            
            
        } failure:^(__kindof YTKBaseRequest *request) {
            [weakself hiddenMBHud];
            [weakself showMBHud:@"请检查网络连接"];
            
            weakself.noConnectionView = [[YMNoInternetConnection alloc]initWithFrame:Rect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [weakself.view addSubview:weakself.noConnectionView];
            [weakself.view bringSubviewToFront:weakself.noConnectionView];
            weakself.noConnectionView.clickBlock = ^(){
                
                [weakself requestFromSever];
                
            };
        }];

    }else if (_selectIndex == 1){//流水
        
        YMHomeMoneyDetailAPI *moneyDetail = [[YMHomeMoneyDetailAPI alloc] initStatus:@"0" andYear:_yearNum andMonth:_monthNum andDay:_dayNum andPage:_pageIndex];
        
        [moneyDetail startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            
            [weakself hiddenMBHud];
            [weakself.noConnectionView hiddenNoConnectionView];
            //        NSLog(@"data --- %@",request.responseJSONObject);
            NSArray * tempArr = [request.responseJSONObject objectForKey:@"data"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (int i = 0; i<tempArr.count; i ++) {
                
                NSDictionary *tempDic = tempArr[i];
                NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
                
                [tempDictionary setObject:tempDic[@"ref_id"] forKey:@"ref_id"];
                [tempDictionary setObject:tempDic[@"salon_id"] forKey:@"salon_id"];
                [tempDictionary setObject:tempDic[@"insert_time"] forKey:@"insert_time"];
                [tempDictionary setObject:tempDic[@"type"] forKey:@"type"];
                [tempDictionary setObject:tempDic[@"manager_id"] forKey:@"manager_id"];
                [tempDictionary setObject:tempDic[@"customer_tip"] forKey:@"customer_tip"];
                [tempDictionary setObject:tempDic[@"expire"] forKey:@"expire"];
                [tempDictionary setObject:tempDic[@"name"] forKey:@"name"];
                [tempDictionary setObject:tempDic[@"id"] forKey:@"id"];
                [tempDictionary setObject:tempDic[@"customer_name"] forKey:@"customer_name"];
                [tempDictionary setObject:tempDic[@"detail"] forKey:@"detail"];
                [tempDictionary setObject:tempDic[@"customer_id"] forKey:@"customer_id"];
                [tempDictionary setObject:tempDic[@"status"] forKey:@"status"];
                
                NSString *timeString = [tempArr[i] objectForKey:@"insert_time"];
                
                [weakself changeTime:timeString result:^(NSString*date, NSString *year, NSString *month, NSString *day, NSString*time) {
                    
                    //                NSLog(@"date - %@,time === %@ - %@ - %@ - %@",date,year,month,day,time);
                    [tempDictionary setObject:date forKey:@"groupTime"];
                    [tempDictionary setObject:date forKey:@"date"];
                    [tempDictionary setObject:year forKey:@"year"];
                    [tempDictionary setObject:month forKey:@"month"];
                    [tempDictionary setObject:day forKey:@"day"];
                    [tempDictionary setObject:time forKey:@"time"];
                    
                }];
                
                [dataArray addObject:tempDictionary];
                
            }
            [weakself showMBHud:request.responseJSONObject[@"msg"]];
            
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
                
                weakself.noConnectionView = [[YMNoInternetConnection alloc]initWithFrame:Rect(0, 50+SCREEN_WIDTH/6+SCREEN_WIDTH/7+10, SCREEN_WIDTH, SCREEN_HEIGHT) andType:NO];
                
                [weakself.view addSubview:weakself.noConnectionView];
            }
            [weakself.tableView reloadData];
            
            
        } failure:^(__kindof YTKBaseRequest *request) {
            [weakself hiddenMBHud];
            [weakself showMBHud:@"请检查网络连接"];
            
            weakself.noConnectionView = [[YMNoInternetConnection alloc]initWithFrame:Rect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [weakself.view addSubview:weakself.noConnectionView];
            [weakself.view bringSubviewToFront:weakself.noConnectionView];
            weakself.noConnectionView.clickBlock = ^(){
                
                [weakself requestFromSever];
                
            };
        }];
    }else if (_selectIndex == 2){
        
        YMHomeExpireAPI *expireAPI = [[YMHomeExpireAPI alloc] initStatus:@"1" andExpire:@"2" andPage:_pageIndex];
        
        [expireAPI startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            
            [weakself hiddenMBHud];
            [weakself.noConnectionView hiddenNoConnectionView];
            //        NSLog(@"data --- %@",request.responseJSONObject);
            NSArray * tempArr = [request.responseJSONObject objectForKey:@"data"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (int i = 0; i<tempArr.count; i ++) {
                
                NSDictionary *tempDic = tempArr[i];
                NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
                
                [tempDictionary setObject:tempDic[@"ref_id"] forKey:@"ref_id"];
                [tempDictionary setObject:tempDic[@"salon_id"] forKey:@"salon_id"];
                [tempDictionary setObject:tempDic[@"insert_time"] forKey:@"insert_time"];
                [tempDictionary setObject:tempDic[@"type"] forKey:@"type"];
                [tempDictionary setObject:tempDic[@"manager_id"] forKey:@"manager_id"];
                [tempDictionary setObject:tempDic[@"customer_tip"] forKey:@"customer_tip"];
                [tempDictionary setObject:tempDic[@"expire"] forKey:@"expire"];
                [tempDictionary setObject:tempDic[@"name"] forKey:@"name"];
                [tempDictionary setObject:tempDic[@"id"] forKey:@"id"];
                [tempDictionary setObject:tempDic[@"customer_name"] forKey:@"customer_name"];
                [tempDictionary setObject:tempDic[@"detail"] forKey:@"detail"];
                [tempDictionary setObject:tempDic[@"customer_id"] forKey:@"customer_id"];
                [tempDictionary setObject:tempDic[@"status"] forKey:@"status"];
                
                NSString *timeString = [tempArr[i] objectForKey:@"insert_time"];
                
                [weakself changeTime:timeString result:^(NSString*date, NSString *year, NSString *month, NSString *day, NSString*time) {
                    
                    //                NSLog(@"date - %@,time === %@ - %@ - %@ - %@",date,year,month,day,time);
                    [tempDictionary setObject:date forKey:@"groupTime"];
                    [tempDictionary setObject:date forKey:@"date"];
                    [tempDictionary setObject:year forKey:@"year"];
                    [tempDictionary setObject:month forKey:@"month"];
                    [tempDictionary setObject:day forKey:@"day"];
                    [tempDictionary setObject:time forKey:@"time"];
                    
                }];
                
                [dataArray addObject:tempDictionary];
                
            }
            [weakself showMBHud:request.responseJSONObject[@"msg"]];
            
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
                
                weakself.noConnectionView = [[YMNoInternetConnection alloc]initWithFrame:Rect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) andType:NO];
                
                [weakself.view addSubview:weakself.noConnectionView];
            }
            [weakself.tableView reloadData];
            
            
        } failure:^(__kindof YTKBaseRequest *request) {
            [weakself hiddenMBHud];
            [weakself showMBHud:@"请检查网络连接"];
            
            weakself.noConnectionView = [[YMNoInternetConnection alloc]initWithFrame:Rect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [weakself.view addSubview:weakself.noConnectionView];
            [weakself.view bringSubviewToFront:weakself.noConnectionView];
            weakself.noConnectionView.clickBlock = ^(){
                
                [weakself requestFromSever];
                
            };
        }];
    }
    
//    NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:@{@"userID":@"1",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"2",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"3",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"4",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"5",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"6",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"十月"},@{@"userID":@"7",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"8",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"9",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"九月"},@{@"userID":@"10",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"11",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"十月"},@{@"userID":@"12",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"13",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"14",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"本月"},@{@"userID":@"15",@"name":@"李志斌",@"descriptionText":@"开背|开胸|电疗背|颈护",@"status":@"等待确认",@"date":@"今天",@"time":@"10.14",@"groupTime":@"九月"}, nil];
    
    
//    if (_currentIndex == 0) {
//        
//        __weak typeof(self) weakself = self;
//        
//        NSArray *pbaseArr = dataArray;
//        
//        NSMutableArray *addTempArray = [NSMutableArray array];
//        if (weakself.isRefresh) {
//            
//            addTempArray = dataArray;
//            [weakself.addArray removeAllObjects];
//            [weakself.addArray addObjectsFromArray:pbaseArr];
//        }else{
//            
//            [weakself.marksArray removeAllObjects];
//            [weakself.addArray addObjectsFromArray:pbaseArr];
//            [addTempArray addObjectsFromArray:weakself.addArray];
//        }
//        
//        NSMutableArray *dataArr = [NSMutableArray array];
//        
//        for (int j = 0; j < addTempArray.count; j++) {
//            
//            NSString *title = [addTempArray[j] objectForKey:@"groupTime"];
//            
//            NSMutableArray *datalist = [@[] mutableCopy];
//            
//            NSMutableDictionary *dataDic = [@{} mutableCopy];
//            
//            [datalist addObject:addTempArray[j]];
//            
//            for (int k = j+1; k < addTempArray.count; k ++) {
//                
//                if ([title isEqualToString:[addTempArray[k] objectForKey:@"groupTime"]]) {
//                    
//                    [datalist addObject:addTempArray[k]];
//                    
//                    [addTempArray removeObjectAtIndex:k];
//                    
//                    k = k-1;
//                }
//                
//            }
//            
//            [dataDic setObject:title forKey:@"groupTime"];
//            [dataDic setObject:datalist forKey:@"datalist"];
//            [dataArr addObject:dataDic];
//            
//        }
//        
//        [weakself.sectionArray removeAllObjects];
//        [weakself.dataArray removeAllObjects];
//        
//        if (weakself.isRefresh) {
//            
//            [weakself.tableView.mj_header endRefreshing];
//        }else{
//            
//            
//            if ([(NSArray *)dataArray count] == 0) {
//                
//                [weakself showMBHud:@"暂无更多数据！"];
//            }
//            [weakself.tableView.mj_footer endRefreshing];
//        }
//        
//        [weakself.sectionArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArr]];
//        
//        NSArray *tempArray = [[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArr] valueForKey:@"datalist"];
//        
//        [weakself.dataArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:tempArray]];
//        
//        if (weakself.dataArray.count == 0) {
//            
//            //        weakself.noConnectionView = [[LQNoInternetConnection alloc]initWithFrame:Rect(0, ViewBavBarH+45, SCREEN_WIDTH, SCREEN_HEIGHT) andType:NO];
//            //
//            //        [weakself.view addSubview:weakself.noConnectionView];
//        }
//        [weakself.tableView reloadData];
//    }else if (_currentIndex == 1){
//    
//        if (self.isRefresh) {
//            
//            [self.tableView.mj_header endRefreshing];
//        }else{
//            
//            [self.tableView.mj_footer endRefreshing];
//        }
//        [self.dataArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArray]];
//    }else if (_currentIndex == 2){
//    
//        [self.dataArray addObjectsFromArray:[WaitingConfirmationModel mj_objectArrayWithKeyValuesArray:dataArray]];
//        if (self.isRefresh) {
//            
//            [self.tableView.mj_header endRefreshing];
//        }else{
//            
//            [self.tableView.mj_footer endRefreshing];
//        }
//    }
    
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
