//
//  YMHomeMainViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMHomeMainViewController.h"
#import "YMHomeMainCollectionViewCell.h"
#import "YMTopBarView.h"
#import "YMLoginViewController.h"

#import "YMHomeSelectStoreView.h"
@interface YMHomeMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView            *collectionView;

@property(nonatomic,strong) UICollectionViewFlowLayout  *collectionLayout;

@property(strong,nonatomic) YMTopBarView                *topBarView;

@property(strong,nonatomic) UIView                      *selectStore;//选择店铺

@end
static NSString *const ID = @"homeMainCollectionViewCellIdentifier";
@implementation YMHomeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewNaviBar setAlpha:0];

    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    self.collectionLayout = layout;
    
    UICollectionView *collectionView    = [[UICollectionView alloc] initWithFrame:Rect(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-65) collectionViewLayout:layout];
    collectionView.backgroundColor      = UIColorFromRGB(0xffffff);
    [collectionView registerClass:[YMHomeMainCollectionViewCell class] forCellWithReuseIdentifier:ID];
    self.collectionView                 = collectionView;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
//    self.collectionView.scrollEnabled   = NO;
    
    layout.minimumInteritemSpacing      = 0;
    layout.minimumLineSpacing           = 0;
    layout.scrollDirection              = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled   = YES;
    self.collectionView.bounces         = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
    
    NSArray * titleArray = @[@"等待确认",@"流水明细",@"套餐到期"];
    __weak typeof(self) weakself = self;
    
    _topBarView=[[YMTopBarView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 45) titles:titleArray clickBlick:^void(NSInteger index) {
        NSLog(@"-----%ld",index);
        [weakself.collectionView setContentOffset:CGPointMake(SCREEN_WIDTH*(index-1), 0)];

    }];
    [self.view addSubview:_topBarView];
    
//    [self.view addSubview:_topbar];
    YMUserInfoData * userInfo = [[YMUserInfoMgr sharedInstance] getUserProfile];

    if (userInfo.token.length == 0) {
        
        YMLoginViewController *login =[YMLoginViewController new];
        [weakself presentViewController:login animated:NO completion:^{
            
        }];
        return;
    }else{
    
        if (userInfo.salonMapList.count > 1) {
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            _selectStore = [[UIView alloc] initWithFrame:Rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            _selectStore.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
            [keyWindow addSubview:_selectStore];
            
            YMHomeSelectStoreView *selectView = [[YMHomeSelectStoreView alloc] initWithFrame:Rect(_selectStore.centerX-W(516)/2, _selectStore.centerY-W(440)/2, W(516), W(440))];
            selectView.layer.masksToBounds = YES;
            selectView.layer.cornerRadius = 15;
            selectView.selectStoreDataArray = userInfo.salonMapList;
            [_selectStore addSubview:selectView];
            
            selectView.selectStoreBlock = ^(NSInteger index) {
                
                userInfo.manager_id = [userInfo.salonMapList[index] objectForKey:@"manager_id"];
                userInfo.salon_id   = [userInfo.salonMapList[index] objectForKey:@"salon_id"];
                [[YMUserInfoMgr sharedInstance] setUserInfoData:userInfo];
                
                [weakself.selectStore removeFromSuperview];
            };
        }else{
        
            userInfo.manager_id = [userInfo.salonMapList[0] objectForKey:@"manager_id"];
            userInfo.salon_id   = [userInfo.salonMapList[0] objectForKey:@"salon_id"];
            [[YMUserInfoMgr sharedInstance] setUserInfoData:userInfo];
        }
        
    }
    NSLog(@"---%@",userInfo.salonMapList);
    
    // Do any additional setup after loading the view.
}

#pragma  mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    
    [_topBarView updateselectLineFrameWithoffset:point.x];
}
// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView==_collectionView)
    {
        NSInteger p=_collectionView.contentOffset.x/SCREEN_WIDTH;
        _topBarView.defaultIndex=p+1;
        
    }
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

#pragma Mark --- dataSourde
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YMHomeMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.selectIndex = indexPath.item;
    
    cell.fatherVC = self;
    
    return cell;
}
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    self.collectionLayout.itemSize = self.collectionView.bounds.size;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
}
- (void)dealloc{
    
    NSLog(@"报名管理 --- 释放内存");
    _collectionView = nil;
    _collectionLayout = nil;
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    _collectionView = nil;
    
    _collectionLayout = nil;
    
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
