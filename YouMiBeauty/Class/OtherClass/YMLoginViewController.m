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
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self ym_controls];
    // Do any additional setup after loading the view.
}
- (void)ym_controls{

    self.view.backgroundColor = [UIColor whiteColor];
    _userFlag = FALSE;
    _pswFlag = FALSE;
    UIImage *logoImage = [UIImage imageNamed:@"login_logo"];
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [self.view addSubview:logoImageView];
    logoImageView.image = logoImage;
    logoImageView.sd_layout
    .topSpaceToView(self.view,W(200))
    .centerXEqualToView(self.view)
    .widthIs(logoImage.size.width)
    .heightIs(logoImage.size.height);
    
    /**
     *  用户名图片
     */
    UIImage *userImage = [UIImage imageNamed:@"usericon"];
    UIImageView *userImageView = [UIImageView new];
    userImageView.image =userImage;
    [self.view addSubview:userImageView];
    userImageView.sd_layout
    .leftSpaceToView(self.view,W(100))
    .topSpaceToView(logoImageView,W(160))
    .widthIs(userImage.size.width)
    .heightIs(userImage.size.height);
    
    /**
     *  手机号输入框
     */
    
    UITextField *userPhoneField = [UITextField new];
    userPhoneField.placeholder = @"请输入你的帐号";
    userPhoneField.font = UIBaseFont(16);
//    userPhoneField.inputAccessoryView = [self toolBar];
    userPhoneField.keyboardType =UIKeyboardTypeNumberPad;
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    userPhoneField.text = [userInfo objectForKey:@"defaultPhone"];
    [self.view addSubview:userPhoneField];
    userPhoneField.delegate =self;
    _userNameTextField = userPhoneField;
    
    userPhoneField.sd_layout
    .leftSpaceToView(userImageView,15)
    .centerYEqualToView(userImageView)
    .widthIs(SCREEN_WIDTH-W(200)-userImageView.size.width-15)
    .heightIs(25);
    
    /**
     *中间线
     */
    UIView *centerLineView = [UIView new];
    centerLineView.backgroundColor = UIColorFromRGB(0x929394);
    [self.view addSubview:centerLineView];
    centerLineView.sd_layout
    .leftSpaceToView(self.view,W(100))
    .topSpaceToView(userImageView,14.5)
    .widthIs(SCREEN_WIDTH-W(200))
    .heightIs(1);
    
    /**
     *密码图
     */
    
    UIImage *passwordImage = [UIImage imageNamed:@"keyicon"];
    UIImageView *passwordImageView = [UIImageView new];
    passwordImageView.image =passwordImage;
    [self.view addSubview:passwordImageView];
    passwordImageView.sd_layout
    .leftSpaceToView(self.view,W(100))
    .topSpaceToView(centerLineView,W(60))
    .widthIs(passwordImage.size.width)
    .heightIs(passwordImage.size.height);
    
    /**
     *密码框
     */
    UITextField *passwordField = [UITextField new];
    passwordField.placeholder = @"请输入手机验证码";
//    passwordField.inputAccessoryView = [self toolBar];
    passwordField.font = UIBaseFont(16);
    passwordField.delegate =self;//15006037330
//    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    _passwordTextField = passwordField;
    
    passwordField.sd_layout
    .leftEqualToView(_userNameTextField)
    .centerYEqualToView(passwordImageView)
    .widthIs(16*8)
    .heightIs(25);
    
    [_passwordTextField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    [_userNameTextField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    
    
    /**
     *底部线
     */
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = UIColorFromRGB(0x929394);
    [self.view addSubview:bottomLineView];
    bottomLineView.sd_layout
    .leftSpaceToView(self.view,W(100))
    .topSpaceToView(passwordImageView,14)
    .widthIs(SCREEN_WIDTH-W(200))
    .heightIs(1);
    
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.backgroundColor = UIColorFromRGB(0xf73373);
    codeBtn.layer.cornerRadius = 17;
    codeBtn.layer.masksToBounds = YES;
    [codeBtn setTitle:@"发送验证码" forState:0];
    codeBtn.titleLabel.font = UIBaseFont(15);
    [codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    
    codeBtn.sd_layout
    .centerYEqualToView(passwordField)
    .rightEqualToView(bottomLineView)
    .widthIs(15*6)
    .heightIs(34);
    /**
     *登陆按钮
     */
    
    UIImage *loginButtonImage = [UIImage imageNamed:@"icon_home_buttonpic"];
    _loginButton = [UIButton new];
    [_loginButton setBackgroundImage:loginButtonImage forState:0];
    [self.view addSubview:_loginButton];
    [_loginButton setTitle:@"登 录" forState:0];
    [_loginButton.titleLabel setFont:UIBaseFont(W(40))];
    _loginButton.sd_layout
    .leftSpaceToView(self.view,W(100))
    .topSpaceToView(bottomLineView,W(154))
    .widthIs(SCREEN_WIDTH - W(200))
    .heightIs(loginButtonImage.size.height);

    [_loginButton addTarget:self action:@selector(loginRequest) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginButton.enabled = NO;
    
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
            if (textField.text.length>=4&&textField.text.length<16 && _userNameTextField.text.length == 11) {
                
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
- (void)getCode{

    __weak typeof(self) weakself = self;
    
    [self showSenderToServer:@"发送中..."];
    YMLoginGetCodeAPI *getCodeAPI = [[YMLoginGetCodeAPI alloc] initPhoneNum:_userNameTextField.text];
    
    [getCodeAPI startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [weakself hiddenMBHud];
        NSLog(@"data --- %@",request.responseJSONObject);
        [weakself showMBHud:request.responseJSONObject[@"msg"]];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [self hiddenMBHud];
        
        [weakself showMBHud:@"请检查网络连接"];
        NSLog(@"************* --- 请求数据失败");
    }];
    
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
    YMLoginAPI *loginRequest = [[YMLoginAPI alloc] initPhoneNum:_userNameTextField.text andCode:_passwordTextField.text];
    
    [loginRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [weakself hiddenMBHud];
        NSDictionary *dataDic       = request.responseJSONObject[@"data"];
        
        
        NSNumber     *errorCode = request.responseJSONObject[@"code"];
        NSLog(@"data --- %@",request.responseJSONObject);
        if ([errorCode integerValue] == 1) {//登录成功
            
            
            
            [userInfo setObject:dataDic[@"token"] forKey:@"token"];
            [userInfo setObject:dataDic[@"id"] forKey:@"userid"];
            [userInfo setObject:dataDic[@"name"] forKey:@"username"];
            [userInfo setObject:dataDic[@"phone"] forKey:@"defaultPhone"];//默认登陆号码
            [userInfo synchronize];
            
            
            //                [self dismissViewControllerAnimated:YES completion:nil];
            YMHomeMainViewController *mainVC = [[YMHomeMainViewController alloc] init];
            
            YMNavigationContrller *nav = [[YMNavigationContrller alloc] initWithRootViewController:mainVC];
            
            [weakself presentViewController:nav animated:YES completion:^{
                [weakself.view removeFromSuperview];
            }];
            
        }else{
            [weakself hiddenMBHud];
            [weakself showMBHud:request.responseJSONObject[@"msg"]];
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
