//
//  YMCustomerViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMCustomerViewController.h"
#import "YMCustomerModel.h"
#import "YMCustomerCell.h"
#import "pinyin.h"
@interface YMCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView       *tableView;

@property(nonatomic,strong) NSMutableArray      *dataSource;//数据源
/** 排序后所有联系人 */
@property(nonatomic,strong) NSMutableArray      *userSource;
@property(nonatomic,strong) NSMutableArray      *numArray;
@property(nonatomic,strong) NSMutableDictionary *dict;
@property(nonatomic,strong) NSDictionary        *tempDic;

@end

@implementation YMCustomerViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
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
//    [self.viewNaviBar setAlpha:0];
    [self.viewNaviBar setTitle:@"客户"];
    [self hiddenBackBtn:YES];
    
    
    [self.view addSubview:self.tableView];
    
    [self requestFromSever];
    // Do any additional setup after loading the view.
}
-(UITableView*)tableView
{
    CGRect frame = self.view.bounds;
    frame.origin.y    = NavBarHeight-20;
    frame.size.height = SCREEN_HEIGHT-NavBarHeight-49+20;
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorFromRGB(0xffffff);
        _tableView.separatorColor = [UIColor redColor];
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
    YMCustomerModel *model = [array objectAtIndex:indexPath.row];
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
    YMCustomerModel *model = [array objectAtIndex:indexPath.row];
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

//#pragma mark 设置cell分割线做对齐
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
//    }
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
//    }
//}
//
//-(void)viewDidLayoutSubviews {
//    
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
//        
//    }
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
//    }
//    
//}
#pragma Mark --- 数据请求

- (void)requestFromSever{
    
    /**
     *  请求数据
     */
    
    NSArray *data = @[@{@"uid":@"1",@"nickname":@"阿猫",@"picurl":@"http://xiuxin-1253234316.costj.myqcloud.com/giftImages/header.png"}];
    [self.dataSource addObjectsFromArray:[YMCustomerModel mj_objectArrayWithKeyValuesArray:data]];
    
    [self sortDatas];
//    [_tableView reloadData];
    
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
            YMCustomerModel *model = [self.dataSource objectAtIndex:j];
            
            //获取姓名首位
            NSString *firstName;
            firstName = model.nickname;
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
        
        YMCustomerModel *model = [self.dataSource objectAtIndex:j];
        
        //获取姓名首位
        NSString *firstName;
        firstName = model.nickname;
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
    
    //        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"{search}",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
