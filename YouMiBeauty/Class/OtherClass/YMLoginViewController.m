//
//  YMLoginViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMLoginViewController.h"
#import "MBProgressHUD.h"
#import "YMHomeMainViewController.h"
#import "YMNavigationContrller.h"
@interface YMLoginViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,assign)BOOL userFlag;
@property(nonatomic,assign)BOOL pswFlag;
@property(nonatomic,strong)UIButton *loginButton;

@end

@implementation YMLoginViewController

+(YMLoginViewController*)shareLoginViewController
{
    static dispatch_once_t predicate;
    static YMLoginViewController *shareLoginViewController;
    dispatch_once(&predicate,^{
        shareLoginViewController = [[YMLoginViewController alloc] init];
    });
    return shareLoginViewController;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewNaviBar.hidden = YES;
    [self ym_controls];
    // Do any additional setup after loading the view.
}
- (void)ym_controls{

    self.view.backgroundColor = [UIColor whiteColor];
    _userFlag = FALSE;
    _pswFlag = FALSE;
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius  = 4.0f;
    logoImageView.frame =Rect(self.view.centerX-40, 64, 80, 80);
    [self.view addSubview:logoImageView];
    logoImageView.image = logoImage;
    /**
     *  顶部线条
     */
    UIImage *lineImage = [UIImage imageNamed:@"loginLine"];
    
    UIImageView *topLineImageView = [UIImageView new];
    [topLineImageView setImage:lineImage];
    [self.view addSubview:topLineImageView];
    topLineImageView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,W(364))
    .widthIs(SCREEN_WIDTH)
    .heightIs(lineImage.size.height);
    
    /**
     *  头像图片
     */
    UIImage *userImage = [UIImage imageNamed:@"login_user"];
    UIImageView *userImageView = [UIImageView new];
    userImageView.image =userImage;
    [self.view addSubview:userImageView];
    userImageView.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(topLineImageView,14.5)
    .widthIs(userImage.size.width)
    .heightIs(userImage.size.height);
    
    /**
     *  手机号输入框
     */
    
    UITextField *userPhoneField = [UITextField new];
    userPhoneField.placeholder = @"请输入手机号";
    userPhoneField.font = UIBaseFont(14);
//    userPhoneField.inputAccessoryView = [self toolBar];
    userPhoneField.keyboardType =UIKeyboardTypeNumberPad;
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    userPhoneField.text = [userInfo objectForKey:@"default"];
    [self.view addSubview:userPhoneField];
    userPhoneField.delegate =self;
    _userNameTextField = userPhoneField;
    
    userPhoneField.sd_layout
    .leftSpaceToView(userImageView,15)
    .topSpaceToView(topLineImageView,13)
    .widthIs(300)
    .heightIs(25);
    /**
     *中间线
     */
    UIImageView *centerLineImageView = [UIImageView new];
    [centerLineImageView setImage:lineImage];
    [self.view addSubview:centerLineImageView];
    centerLineImageView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(userImageView,14.5)
    .widthIs(SCREEN_WIDTH)
    .heightIs(lineImage.size.height);
    
    /**
     *密码图
     */
    
    UIImage *passwordImage = [UIImage imageNamed:@"login_password"];
    UIImageView *passwordImageView = [UIImageView new];
    passwordImageView.image =passwordImage;
    [self.view addSubview:passwordImageView];
    passwordImageView.sd_layout
    .leftSpaceToView(self.view,16)
    .topSpaceToView(centerLineImageView,14)
    .widthIs(passwordImage.size.width)
    .heightIs(passwordImage.size.height);
    
    /**
     *密码框
     */
    UITextField *passwordField = [UITextField new];
    passwordField.placeholder = @"请输入密码";
//    passwordField.inputAccessoryView = [self toolBar];
    passwordField.font = UIBaseFont(14);
    passwordField.delegate =self;//15006037330
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    _passwordTextField = passwordField;
    
    passwordField.sd_layout
    .leftSpaceToView(userImageView,16)
    .topSpaceToView(centerLineImageView,12)
    .widthIs(300)
    .heightIs(25);
    [_passwordTextField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    [_userNameTextField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    
    
    /**
     *底部线
     */
    UIImageView *bommLineImageView = [UIImageView new];
    [bommLineImageView setImage:lineImage];
    [self.view addSubview:bommLineImageView];
    bommLineImageView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(passwordImageView,14)
    .widthIs(SCREEN_WIDTH)
    .heightIs(lineImage.size.height);
    
    /**
     *登陆按钮
     */
    
    UIImage *loginButtonImage = [UIImage imageNamed:@"login_btn"];
    _loginButton = [UIButton new];
    [_loginButton setBackgroundImage:loginButtonImage forState:0];
    _loginButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:_loginButton];
    [_loginButton setTitle:@"登录" forState:0];
    [_loginButton.titleLabel setFont:UIBaseFont(14)];
    _loginButton.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(bommLineImageView,50)
    .widthIs(SCREEN_WIDTH - 30)
//    .heightIs(loginButtonImage.size.height);
    .heightIs(50);
    [_loginButton addTarget:self action:@selector(loginRequest) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginButton.enabled = NO;
    
    
    //客服电话
    UILabel *phoneNumLabel = [[UILabel alloc] initWithFrame:Rect(-15, SCREEN_HEIGHT-35, SCREEN_WIDTH, 15)];
    phoneNumLabel.text =@"客服电话:400-683-5099";
    phoneNumLabel.font = UIBaseFont(14);
    phoneNumLabel.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:phoneNumLabel];
    
    UIImage *image = [UIImage imageNamed:@"phone_call"];
    UIButton *phoneImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneImageView setBackgroundImage:image forState:0];
    phoneImageView.frame = Rect(self.view.centerX+70, SCREEN_HEIGHT-37, image.size.width, image.size.height);
    [self.view addSubview:phoneImageView];
    [phoneImageView setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [phoneImageView addTarget:self action:@selector(phoneCallClicked) forControlEvents:UIControlEventTouchUpInside];
}
-(void)phoneCallClicked{
    
//    [LQCommonUtils callTelphoneNum:@"4006835099"];
    
}
/**
 *实时监测键盘变化
 */
-(void)valueChanged:(UITextField*)textField
{
    if (textField ==_userNameTextField) {
        if (textField.text.length ==11) {
            _userFlag = TRUE;
        }
        else{
            _userFlag = FALSE;
        }
    }
    else
    {
        if (textField==_passwordTextField) {
            if (textField.text.length>=6&&textField.text.length<16 && _userNameTextField.text.length == 11) {
                
                _userFlag = TRUE;
                _pswFlag = TRUE;
            }
            else
            {
                _pswFlag = FALSE;
            }
        }
    }
    if (_pswFlag&&_userFlag) {
        self.loginButton.enabled = YES;
    }
    else
    {
        self.loginButton.enabled = NO;
        
    }
}
-(void)showSenderToServer:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud.label.text =title;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
}

-(void)hiddenMBHud
{
    BOOL hud = [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSLog(@"hud ==%d",hud);
}
-(void)showMBHud:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, 0.f);
    
    [hud hideAnimated:YES afterDelay:2.f];
    
}

-(void)loginRequest
{
    __weak typeof(self) weakself = self;
    
    [self showSenderToServer:@"登录中..."];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [userInfo objectForKey:@"deviceToken"];
    if (deviceToken.length==0) {
        deviceToken =@"";
    }
    
//    YMHomeMainViewController *mainVC = [[YMHomeMainViewController alloc] init];
//    YMNavigationContrller *nav = [[YMNavigationContrller alloc] initWithRootViewController:mainVC];
//    [weakself presentViewController:nav animated:YES completion:^{
//        [weakself.view removeFromSuperview];
//        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
//        [userInfo setObject:@"1" forKey:@"token"];
//        [userInfo synchronize];
//    }];
    YMLoginAPI *loginRequest = [[YMLoginAPI alloc] initPhoneNum:_userNameTextField.text andCode:@"123123"];
    
    [loginRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [weakself hiddenMBHud];
        NSDictionary *dic       = request.responseJSONObject[@"data"];
        
        
        NSNumber     *errorCode = request.responseJSONObject[@"error_code"];
        NSLog(@"data --- %@",request.responseJSONObject);
        if ( [errorCode.description isEqualToString:@"0"]) {
            
            
            
            [userInfo setObject:dic[@"token"] forKey:@"token"];
            [userInfo setObject:dic[@"userid"] forKey:@"userid"];
            [userInfo setObject:dic[@"username"] forKey:@"username"];
            
            [userInfo setObject:dic[@"username"] forKey:@"default"];//默认登陆号码
            //usertype 	用户类型 	无 	int 	2区域经理 3高级代理 4普通代理 10线下商店 11校米店长
            [userInfo synchronize];
            
            
            //                [self dismissViewControllerAnimated:YES completion:nil];
            YMHomeMainViewController *mainVC = [[YMHomeMainViewController alloc] init];
            
            YMNavigationContrller *nav = [[YMNavigationContrller alloc] initWithRootViewController:mainVC];
            
            [weakself presentViewController:nav animated:YES completion:^{
                [weakself.view removeFromSuperview];
            }];
            
        }else{
            [weakself hiddenMBHud];
            [weakself showMBHud:request.responseJSONObject[@"message"]];
            NSLog(@"*************** --- 登录失败");
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [self hiddenMBHud];
        
        NSLog(@"************* --- 请求数据失败");
    }];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (![string isEqualToString:@""]) {
        NSString *textStr = textField.text;
        if (self.userNameTextField==textField) {
            if (textStr.length>=11) {
                return NO;
            }
            else
            {
                NSInteger current = textStr.length;
                if (0==current) {
                    if ([string isEqualToString:@"1"]) {
                        return YES;
                    }
                    return NO;
                }
                else if (1==current)
                {
                    if ([string isEqualToString:@"3"] || [string isEqualToString:@"4"] || [string isEqualToString:@"5"] || [string isEqualToString:@"7"] || [string isEqualToString:@"8"]) {
                        return YES;
                    }
                    return NO;
                }
                return YES;
            }
        }
        else if (self.passwordTextField ==textField)
        {
            if (textStr.length>=16) {
                return NO;
            }
            else
            {
                NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ZCNALPHANUM] invertedSet];
                NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
                return [string isEqualToString:filtered];
            }
        }
    }
    return YES;
}

-(void)dealloc
{
    
}

-(void)resignFirstResponserToolbar
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
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
