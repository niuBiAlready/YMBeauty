//
//  YMCosmetologistViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMCosmetologistViewController.h"
#import "YMCustomerModel.h"
#import "YMCustomerCell.h"
#import "pinyin.h"

#import "YMLoginViewController.h"
#import "YMSearchTextField.h"
@interface YMCosmetologistViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView       *tableView;

@property(nonatomic,strong) NSMutableArray      *dataSource;//数据源
/** 排序后所有联系人 */
@property(nonatomic,strong) NSMutableArray      *userSource;
@property(nonatomic,strong) NSMutableArray      *numArray;
@property(nonatomic,strong) NSMutableDictionary *dict;
@property(nonatomic,strong) NSDictionary        *tempDic;

@property(nonatomic,strong) YMSearchTextField   *search;
@property(nonatomic,strong) NSString            *searchName;
@property(nonatomic,strong) UIButton            *addButton;//添加按钮

@end

@implementation YMCosmetologistViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (NSMutableArray *)userSource
{
    if (!_userSource) {
        _userSource = [NSMutableArray new];
    }
    return _userSource;
}
- (NSMutableArray *)numArray
{
    if (!_numArray) {
        _numArray = [NSMutableArray new];
    }
    return _numArray;
}

- (NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary new];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewNaviBar setTitle:@"美容师"];
    [self hiddenBackBtn:YES];
    
    __weak typeof(self) weakself = self;
    
    _search = [[YMSearchTextField alloc] initWithFrame:Rect(0, 64, SCREEN_WIDTH, 71)];
    _search.placeholderText = @"搜索你要查找的人名或手机号";
    [self.view addSubview:_search];
    _search.searchAction = ^(NSString *searchText) {
        
        weakself.searchName = searchText;
        [weakself requestFromSever];
    };
    
    [self.view addSubview:self.tableView];
    
    _searchName = @"";
    
    UIImage *addBtnImage = [UIImage imageNamed:@"addbtn"];
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = Rect(SCREEN_WIDTH-10-addBtnImage.size.width, SCREEN_HEIGHT-49-10-addBtnImage.size.height, addBtnImage.size.width, addBtnImage.size.height);
//    [_addButton setImage:addBtnImage forState:0];
    [_addButton setBackgroundImage:addBtnImage forState:0];
    [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
    __unsafe_unretained UITableView *leftTableView = self.tableView;
    
    // 下拉刷新
    leftTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        weakself.searchName = @"";
        [weakself requestFromSever];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    leftTableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self requestFromSever];
    // Do any additional setup after loading the view.
}
- (void)addAction:(UIButton *)sender{

    
}
#pragma  mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentY = scrollView.contentOffset.y;
    UIImage *addBtnImage = [UIImage imageNamed:@"addbtn"];
    if (contentY < 5) {
    
        [UIView animateWithDuration:0.5 animations:^{
            
            _addButton.frame = Rect(SCREEN_WIDTH-10-addBtnImage.size.width, SCREEN_HEIGHT-49-10-addBtnImage.size.height, addBtnImage.size.width, addBtnImage.size.height);
        }];
        
        
    }else{
    
        [UIView animateWithDuration:0.5 animations:^{
            
            _addButton.frame = Rect(SCREEN_WIDTH, SCREEN_HEIGHT-49-10-addBtnImage.size.height, addBtnImage.size.width, addBtnImage.size.height);
        }];
    }
}
-(UITableView*)tableView
{
    CGRect frame = self.view.bounds;
    frame.origin.y    = NavBarHeight+71;
    frame.size.height = SCREEN_HEIGHT-NavBarHeight-49-71;
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorFromRGB(0xffffff);
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexTrackingBackgroundColor=[UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _userSource.count;
}

#pragma mark - 设置每个section里的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [self.userSource objectAtIndex:section];
    NSArray *array = [[dic allValues] firstObject];
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"LQMyAgencyTableViewCell";
    YMCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[YMCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [self.userSource objectAtIndex:indexPath.section];
    NSArray *array = [[dic allValues] lastObject];
    YMCosmetologist *model = [array objectAtIndex:indexPath.row];
    [cell setCellForModel:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [self.userSource objectAtIndex:indexPath.section];
    NSMutableArray *array = [[dic allValues] lastObject];
    YMCosmetologist *model = [array objectAtIndex:indexPath.row];
    //    if (_currentIndex == 0) {
    //        LQAgencySchoolDetailController *agencySchool = [LQAgencySchoolDetailController new];
    //        agencySchool.schoolName = model.school_name;
    //        agencySchool.schoolID   = model.id;
    //        [self.navigationController pushViewController:agencySchool animated:YES];
    //    }else{
    //
    //        LQAgencyDetailController *agencyDetail = [LQAgencyDetailController new];
    //        agencyDetail.nameString = model.nickname;
    //        agencyDetail.agencyId   = model.uid;
    //        [self.navigationController pushViewController:agencyDetail animated:YES];
    //    }
}
#pragma mark - 设置section显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [self.userSource objectAtIndex:section];
    NSNumber *num = [[dic allKeys] lastObject];
    char *a = (char *)malloc(2);
    sprintf(a, "%c", [num charValue]);
    NSString *str = [[NSString alloc] initWithUTF8String:a];
    
    UILabel *label = [[UILabel alloc] initWithFrame:Rect(0, 0, SCREEN_WIDTH , 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font          = UIBaseFont(15);
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    label.text = [@"  " stringByAppendingString:str];
    return label;
    
}

#pragma mark 设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)viewDidLayoutSubviews {

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];

    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

}
#pragma Mark --- 数据请求

- (void)requestFromSever{
    
    /**
     *  请求数据
     */
    __weak typeof(self) weakself = self;
    
    [self showSenderToServer:@""];
    YMCosmetologistAPI *cosmetologistAPI = [[YMCosmetologistAPI alloc] initName:_searchName];
    
    [cosmetologistAPI startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [weakself hiddenMBHud];
//        NSLog(@"data --- %@",request.responseJSONObject);
        
        NSString *code = request.responseJSONObject[@"code"];
        if ([code integerValue] == -2) {

            YMLoginViewController *login =[YMLoginViewController new];
            [weakself presentViewController:login animated:NO completion:^{

            }];
        }else if([code integerValue] == 1){
            
            NSArray *data = request.responseJSONObject[@"data"];
            
            [weakself.dataSource removeAllObjects];
            [weakself.userSource removeAllObjects];
            [weakself.numArray removeAllObjects];
            
            [weakself.dataSource addObjectsFromArray:[YMCosmetologist mj_objectArrayWithKeyValuesArray:data]];
            
            [weakself.tableView.mj_header endRefreshing];
            
            [weakself sortDatas];
        }else{
        
            [weakself showMBHud:request.responseJSONObject[@"msg"]];
        }
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        [self hiddenMBHud];
        
        [weakself showMBHud:@"请检查网络连接"];
    }];
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView=nil;//
    _dataSource = nil;
    //    self.noConnectionView =nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc
{
    NSLog(@"报名管理列表 --- 内存释放");
    _tableView=nil;//
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    //    self.noConnectionView =nil;
    _dataSource = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 把联系人按字母排序整理
- (void)sortDatas
{
    //处理(中文姓名 或 字母开头姓名)的联系人
    for (char i = 'A'; i<='Z'; i++) {
        
        NSMutableArray *numArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < self.dataSource.count; j++) {
            YMCosmetologist *model = [self.dataSource objectAtIndex:j];
            
            //获取姓名首位
            NSString *firstName;
            firstName = model.name;
            NSString *string = [firstName substringWithRange:NSMakeRange(0, 1)];
            //将姓名首位转换成NSData类型
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            //data的长度大于等于3说明姓名首位是汉字
            if (data.length >= 3)
            {
                //将汉字首字母拿出
                char a = pinyinFirstLetter([firstName characterAtIndex:0]);
                
                //将小写字母转成大写字母
                char b = a - 32;
                
                if (b == i) {
                    [numArray addObject:model];
                    [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                }
            }
            else {
                //data的长度等于1说明姓名首位是字母或者数字
                if (data.length == 1) {
                    //判断姓名首位是否位小写字母
                    NSString * regex = @"^[a-z]$";
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                    BOOL isMatch = [pred evaluateWithObject:string];
                    if (isMatch == YES) {
                        //NSLog(@"这是小写字母");
                        
                        //把大写字母转换成小写字母
                        char j = i+32;
                        //数据封装成NSNumber类型
                        NSNumber *num = [NSNumber numberWithChar:j];
                        //给a开空间，并且强转成char类型
                        char *a = (char *)malloc(2);
                        //将num里面的数据取出放进a里面
                        sprintf(a, "%c", [num charValue]);
                        //把c的字符串转换成oc字符串类型
                        NSString *str = [[NSString alloc]initWithUTF8String:a];
                        
                        if ([string isEqualToString:str]) {
                            [numArray addObject:model];
                            [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                        }
                        
                    }
                    else {
                        //判断姓名首位是否为大写字母
                        NSString * regexA = @"^[A-Z]$";
                        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
                        BOOL isMatchA = [predA evaluateWithObject:string];
                        
                        if (isMatchA == YES) {
                            //NSLog(@"这是大写字母");
                            
                            NSNumber *num = [NSNumber numberWithChar:i];
                            //给a开空间，并且强转成char类型
                            char *a = (char *)malloc(2);
                            //将num里面的数据取出放进a里面
                            sprintf(a, "%c", [num charValue]);
                            //把c的字符串转换成oc字符串类型
                            NSString *str = [[NSString alloc]initWithUTF8String:a];
                            
                            if ([string isEqualToString:str]) {
                                [numArray addObject:model];
                                [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                            }
                        }
                    }
                }
            }
        }
        
        if (dict.count != 0) {
            [self.userSource addObject:dict];
        }
    }
    
    //处理(无姓名 或 数字开头姓名)的联系人
    char n = '#';
    int cont = 0;
    for (int j = 0; j< self.dataSource.count; j++) {
        
        YMCosmetologist *model = [self.dataSource objectAtIndex:j];
        
        //获取姓名首位
        NSString *firstName;
        firstName = model.name;
        //获取姓名的首位
        NSString *string = [firstName substringWithRange:NSMakeRange(0, 1)];
        //将姓名首位转化成NSData类型
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        //判断data的长度是否小于3
        if (data.length < 3) {
            if (cont == 0) {
                cont++;
            }
            if (data.length == 1) {
                //判断首位是否为数字
                NSString * regexs = @"^[0-9]$";
                NSPredicate *preds = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexs];
                BOOL isMatch = [preds evaluateWithObject:string];
                if (isMatch == YES) {
                    //如果姓名为数字
                    [self.numArray addObject:model];
                    [self.dict setObject:self.numArray forKey:[NSNumber numberWithChar:n]];
                }
            }
            else {
                //如果姓名为空
                firstName = @"无";
                //                if (model.telArray.count != 0) {
                //                    [self.numArray addObject:model];
                //                    [self.dict setObject:self.numArray forKey:[NSNumber numberWithChar:n]];
                //                }
            }
        }
    }
    if (self.dict.count != 0) {
        [self.userSource addObject:self.dict];
    }
    
    //主线程刷新UI
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}
#pragma mark - 刷新UI
- (void)updateUI
{
    [_tableView reloadData];
}

#pragma mark - 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
//            NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:@"{search}",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
    NSMutableArray *array = [NSMutableArray array];
    //便立构造器
    for (NSDictionary *dict in self.userSource) {
        //将取出来的数据封装成NSNumber类型
        NSNumber *num = [[dict allKeys] lastObject];
        //给a开空间，并且强转成char类型
        char *a = (char *)malloc(2);
        //将num里面的数据取出放进a里面
        sprintf(a, "%c", [num charValue]);
        //把c的字符串转换成oc字符串类型
        NSString *str = [[NSString alloc]initWithUTF8String:a];
        [array addObject:str];
    }
    return array;
}
#pragma Mark --- 键盘弹出标记
-(void)viewWillAppear:(BOOL)animated
{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
    
    [super viewWillAppear:animated];
    [self hiddenMBHud];
}
//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _search.searchText.frame = Rect(25, 20, SCREEN_WIDTH-80, 31);
        _search.searchBtn.hidden = NO;
    }];
    
}
- (void)handleKeyboardDidHidden{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _search.searchText.frame = Rect(25, 20, SCREEN_WIDTH-50, 31);
        _search.searchBtn.hidden = YES;
    }];
    
}
@end
