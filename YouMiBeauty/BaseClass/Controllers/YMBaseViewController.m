//
//  YMBaseViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/18.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMBaseViewController.h"
#import "YMNavigationContrller.h"
#import "YMLoginViewController.h"
#import "MBProgressHUD.h"
#import "YMReachability.h"
@interface YMBaseViewController ()

@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, assign)BOOL  isNetwork;
@property (nonatomic, strong)YMReachability* internetReachability;

@end

@implementation YMBaseViewController

- (void) reachabilityChanged:(NSNotification *)note
{
    YMReachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[YMReachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(YMReachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
            [self showMBHud:@"当前无网络"];
            _isNetwork =FALSE;
            break;
        case ReachableViaWiFi:
            //            NSLog(@"====当前网络状态为Wifi=======");
            break;
        case ReachableViaWWAN:
            //            NSLog(@"====当前网络状态为3G=======keso");
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isNetwork =TRUE;
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //    //初始化
    //    self.internetReachability=[LQReachability reachabilityForInternetConnection];
    //    //通知添加到Run Loop
    //    [self.internetReachability startNotifier];
    //    [self updateInterfaceWithReachability:_internetReachability];
    
    
    self.view.backgroundColor = UIColorFromRGB(0xf0f0f0);
    if (!_viewNaviBar) {
        _viewNaviBar = [[YMCustomNaviBarView alloc] initWithFrame:Rect(0.0f, 0.0f, [YMCustomNaviBarView barSize].width, [YMCustomNaviBarView barSize].height)];
        _viewNaviBar.m_viewCtrlParent = self;
        [self.view addSubview:_viewNaviBar];
    }
    
    [self navigationCanDragBack:YES];
    
    
}

- (void)requestFromSever{
    
    //    //如果没有网络不去请求服务器
    //    if (!_isNetwork) {
    //        return;
    //    }
}


- (void)dealloc
{
    [UtilityFunc cancelPerformRequestAndNotification:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (BOOL)willDealloc {
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf assertNotDealloc];
    });
    return YES;
}
- (void)assertNotDealloc
{
    //    NSAssert(NO,@"");
    NSLog(@"有内存泄露的地方");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_viewNaviBar && !_viewNaviBar.hidden)
    {
        [self.view bringSubviewToFront:_viewNaviBar];
    }else{
        
    }
}

#pragma mark -

- (void)bringNaviBarToTopmost
{
    if (_viewNaviBar)
    {
        [self.view bringSubviewToFront:_viewNaviBar];
    }else{}
}

- (void)hideNaviBar:(BOOL)bIsHide
{
    _viewNaviBar.hidden = bIsHide;
}
-(void)hiddenBackBtn:(BOOL)isHidden
{
    _viewNaviBar.m_btnBack.hidden = isHidden;
}

- (void)setNaviBarTitle:(NSString *)strTitle
{
    if (_viewNaviBar)
    {
        [_viewNaviBar setTitle:strTitle];
    }else{APP_ASSERT_STOP}
}

- (void)setNaviBarLeftBtn:(UIButton *)btn
{
    if (_viewNaviBar)
    {
        [_viewNaviBar setLeftBtn:btn];
    }else{APP_ASSERT_STOP}
}

- (void)setNaviBarRightBtn:(UIButton *)btn frame:(CGRect)frame
{
    if (_viewNaviBar)
    {
        [_viewNaviBar setRightBtn:btn  frame:frame];
    }else{APP_ASSERT_STOP}
}
-(void)setNaviBarRightLabel:(UILabel*)lab
{
    if (_viewNaviBar) {
        [_viewNaviBar setRightLabel:lab];
    }
    else
    {
        APP_ASSERT_STOP
    }
}
- (void)naviBarAddCoverView:(UIView *)view
{
    if (_viewNaviBar && view)
    {
        [_viewNaviBar showCoverView:view animation:YES];
    }else{}
}

- (void)naviBarAddCoverViewOnTitleView:(UIView *)view
{
    if (_viewNaviBar && view)
    {
        [_viewNaviBar showCoverViewOnTitleView:view];
    }else{}
}

- (void)naviBarRemoveCoverView:(UIView *)view
{
    if (_viewNaviBar)
    {
        [_viewNaviBar hideCoverView:view];
    }else{
        
    }
}

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)bCanDragBack
{
    if (self.navigationController)
    {
        [((YMNavigationContrller *)(self.navigationController)) navigationCanDragBack:bCanDragBack];
    }else{}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  文字
 *
 *  @param title 自动消失
 */
-(void)showMBHud:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, 0.f);
    
    [hud hideAnimated:YES afterDelay:1.0f];
    
    //    NSLog(@"----------------------------------");
}
/**
 *  文字加菊花
 *
 *  @param title
 */
-(void)showSenderToServer:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the label text.
    hud.label.text =title;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
}
- (void)isLogin:(UIViewController *)controller{
    
    __weak typeof(self) weakSelf = self;
//    LQCheckUserLogin *login = [[LQCheckUserLogin alloc] init];
//    [login startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//        if ([[request.responseJSONObject[@"error_code"] description] integerValue]==2) {
//            
//            LQLoginViewController*login = [LQLoginViewController new];
//            LQNavigationContrller *nav = [[LQNavigationContrller  alloc] initWithRootViewController:login];
//            [weakSelf.navigationController presentViewController:nav animated:YES completion:^{
//                
//            }];
//            
//        }else{
//            
//            [weakSelf.navigationController pushViewController:controller animated:YES];
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//        [weakSelf showMBHud:@"请检查网络设置"];
//    }];
    
}
-(void)hiddenMBHud
{
    BOOL hud = [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    NSLog(@"hud ==%d",hud);
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
