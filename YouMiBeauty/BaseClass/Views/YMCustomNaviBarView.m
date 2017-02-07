//
//  YMCustomNaviBarView.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/18.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMCustomNaviBarView.h"

@interface YMCustomNaviBarView ()

@property (nonatomic, readonly) UILabel *m_labelTitle;
@property (nonatomic, readonly) UIImageView *m_imgViewBg;
@property (nonatomic, readonly) UIButton *m_btnLeft;
@property (nonatomic, readonly) UIButton *m_btnRight;
@property (nonatomic, readonly) UILabel  *m_rightLabel;
@property (nonatomic, readonly) BOOL m_bIsBlur;

@end
@implementation YMCustomNaviBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize m_btnBack = _btnBack;
@synthesize m_labelTitle = _labelTitle;
@synthesize m_imgViewBg = _imgViewBg;
@synthesize m_btnLeft = _btnLeft;
@synthesize m_btnRight = _btnRight;
@synthesize m_rightLabel =_rightLabel;
@synthesize m_bIsBlur = _bIsBlur;


+ (CGRect)rightBtnFrame:(CGSize)size
{
    return Rect(SCREEN_WIDTH-60, 22.0f, size.width, size.height);
}
+(CGRect)rightLabelFrame
{
    return Rect(SCREEN_WIDTH-60, 22.0f, 60, 40);
}
+ (CGSize)barBtnSize
{
    return [[self class] setLeftSize];
}

+ (CGSize)barSize
{
    return Size(SCREEN_WIDTH, 64.0f);
}

+ (CGRect)titleViewFrame
{
    return Rect((SCREEN_WIDTH-190)/2, 22.0f, 190.0f, 40.0f);
}

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action
{
    UIButton *btn = [[self class] createImgNaviBarBtnByImgNormal:@"push_back_to" imgHighlight:@"push_back_to" target:target action:action];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:RGB_TextDark forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [UtilityFunc label:btn.titleLabel setMiniFontSize:8.0f forNumberOfLines:1];
    
    return btn;
}

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action
{
    return [[self class] createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight imgSelected:strImg target:target action:action];
}
+(UILabel*)createNavbarRightLabel:(NSString*)str {
    UILabel*rightLabel = [[UILabel alloc] initWithFrame:Rect(SCREEN_WIDTH-70, 0, 60, 40)];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.text = str;
    return rightLabel;
}
+(UIButton*)createCustomRightBtn:(NSString*)btnTitle// target:(id)target action:(SEL)action

{
    UIButton*rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = Rect(SCREEN_WIDTH-60, 20, 50, 44);
    [rightBtn setTitle:btnTitle forState:0];
    return rightBtn;
}
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action
{
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:(strImgSelected ? strImgSelected : strImg)] forState:UIControlStateSelected];
    
    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - imgNormal.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - imgNormal.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _bIsBlur = (IsiOS7Later && Is4Inch);
        
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initUI];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)initUI
{
    self.backgroundColor = NavbgColor;
    self.isPopRootViewController = FALSE;
    self.isBackToComeViewController = TRUE;
    // 默认左侧显示返回按钮
    _btnBack = [[self class] createImgNaviBarBtnByImgNormal:@"back_btn" imgHighlight:@"back_btn" target:self action:@selector(btnBack:)];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelTitle.backgroundColor = [UIColor clearColor];
    _labelTitle.textColor = NavTitleColor;
    _labelTitle.font = [UIFont systemFontOfSize:NavTitleFont18];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    
    _imgViewBg = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgViewBg.image = [[UIImage imageNamed:@"navbg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _imgViewBg.alpha = 0.98f;
    //
    //    if (_bIsBlur)
    //    {// iOS7可设置是否需要现实磨砂玻璃效果
    //        _imgViewBg.alpha = 0.0f;
    //        UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:self.bounds];
    //        [self addSubview:naviBar];
    //    }else{}
    //
    _labelTitle.frame = [[self class] titleViewFrame];
    _imgViewBg.frame = self.bounds;
    
    [self addSubview:_imgViewBg];
    [self addSubview:_labelTitle];
    
    [self setLeftBtn:_btnBack];
}

- (void)setTitle:(NSString *)strTitle
{
    [_labelTitle setText:strTitle];
}

- (void)setLeftBtn:(UIButton *)btn
{
    if (_btnLeft)
    {
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
    }else{}
    
    _btnLeft = btn;
    if (_btnLeft)
    {
        _btnLeft.frame = Rect(10.0f, self.centerY, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
        [self addSubview:_btnLeft];
        [_btnLeft setEnlargeEdgeWithTop:20 right:20 bottom:10 left:10];
    }else{}
}
+(CGSize)setLeftSize
{
    UIImage *image = [UIImage imageNamed:@"back_btn"];
    
    CGSize size = Size(image.size.width,image.size.height);
    return size;
}
-(void)setRightLabel:(UILabel*)lab
{
    if (_rightLabel) {
        [_rightLabel removeFromSuperview];
        _rightLabel = nil;
    }else{}
    _rightLabel =lab;
    if (_rightLabel) {
        _rightLabel.frame = [[self class] rightLabelFrame];
        [self addSubview:_rightLabel];
    }
    else{}
}
- (void)setRightBtn:(UIButton *)btn frame:(CGRect)frame
{
    if (_btnRight)
    {
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }else{}
    
    _btnRight = btn;
    if (_btnRight)
    {
        _btnRight.frame = frame;
        [self addSubview:_btnRight];
    }else{}
}

- (void)btnBack:(id)sender
{
    
    if (self.m_viewCtrlParent)
    {
        if (self.isBackToComeViewController) {
            [self.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            
            if (!self.isPopRootViewController) {
                [self.m_viewCtrlParent.navigationController popToViewController:self.popViewController animated:YES];
            }
            else
            {
                [self.m_viewCtrlParent.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        
    }else{APP_ASSERT_STOP}
}

- (void)showCoverView:(UIView *)view
{
    [self showCoverView:view animation:NO];
}
- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation
{
    if (view)
    {
        [self hideOriginalBarItem:YES];
        
        [view removeFromSuperview];
        
        view.alpha = 0.4f;
        [self addSubview:view];
        if (bIsAnimation)
        {
            [UIView animateWithDuration:0.2f animations:^()
             {
                 view.alpha = 1.0f;
             }completion:^(BOOL f){}];
        }
        else
        {
            view.alpha = 1.0f;
        }
    }else{APP_ASSERT_STOP}
}

- (void)showCoverViewOnTitleView:(UIView *)view
{
    if (view)
    {
        if (_labelTitle)
        {
            _labelTitle.hidden = YES;
        }else{}
        
        [view removeFromSuperview];
        view.frame = _labelTitle.frame;
        
        [self addSubview:view];
    }else{APP_ASSERT_STOP}
}

- (void)hideCoverView:(UIView *)view
{
    [self hideOriginalBarItem:NO];
    if (view && (view.superview == self))
    {
        [view removeFromSuperview];
    }else{}
}

#pragma mark -
- (void)hideOriginalBarItem:(BOOL)bIsHide
{
    if (_btnLeft)
    {
        _btnLeft.hidden = bIsHide;
    }else{}
    if (_btnBack)
    {
        _btnBack.hidden = bIsHide;
    }else{}
    if (_btnRight)
    {
        _btnRight.hidden = bIsHide;
    }else{}
    if (_labelTitle)
    {
        _labelTitle.hidden = bIsHide;
    }else{}
}

@end
