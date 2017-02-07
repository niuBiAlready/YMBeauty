//
//  YMGuideViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMGuideViewController.h"

@interface YMGuideViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *runScrollView;
@property(nonatomic,strong)UIPageControl *pageController;
@property(nonatomic,strong)UIImageView  *lastImageView;

@end

@implementation YMGuideViewController

-(UIScrollView*)runScrollView
{
    if (!_runScrollView) {
        self.runScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _runScrollView.pagingEnabled = YES;
        _runScrollView.delegate = self;
        _runScrollView.bounces = NO;
        _runScrollView.backgroundColor = [UIColor clearColor];
        _runScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT);
    }
    return _runScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.runScrollView];
    
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*.95, SCREEN_WIDTH, 10)];
    self.pageController.currentPageIndicatorTintColor = NavbgColor;
    self.pageController.numberOfPages = 4;
    //    [self.view addSubview:self.pageController];
    CGPoint scrollPoint = CGPointMake(0, 0);
    [self.runScrollView setContentOffset:scrollPoint animated:YES];
    [self createPageView];
}
-(void)createPageView
{
    
    UIImageView *imageViewFirst= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first.jpg"]];
    imageViewFirst.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_runScrollView addSubview:imageViewFirst];
    
    UIImageView *imageViewSecond= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second.jpg"]];
    imageViewSecond.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_runScrollView addSubview:imageViewSecond];
    
    UIImageView *imageViewThree= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"three.jpg"]];
    imageViewThree.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_runScrollView addSubview:imageViewThree];
    
    UIImageView *imageViewFour= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"four.jpg"]];
    imageViewFour.frame = CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_runScrollView addSubview:imageViewFour];
    [_runScrollView setUserInteractionEnabled:YES];
    [imageViewFour setUserInteractionEnabled:YES];
    self.lastImageView =imageViewFour;
    UIImage *image = [UIImage imageNamed:@"jump"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = Rect(self.view.centerX-image.size.width/2, SCREEN_HEIGHT*.86, image.size.width, image.size.height);
    [button setBackgroundImage:image forState:0];
    [imageViewFour addSubview:button];
    [button addTarget:self action:@selector(jumpAppButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}
-(void)jumpAppButtonClicked
{
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(YMGuideViewControllerDelegate)] && [self.delegate respondsToSelector:@selector(guideDoneToShowApp: imageView:)]) {
        [self.delegate guideDoneToShowApp:self imageView:self.lastImageView];
    }
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat PageIndictor = _runScrollView.contentOffset.x/SCREEN_WIDTH;
    self.pageController.currentPage = roundf(PageIndictor);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
