//
//  YMCosmetologistViewController.m
//  YouMiBeauty
//
//  Created by Soo on 2017/1/21.
//  Copyright © 2017年 王涛. All rights reserved.
//

#import "YMCosmetologistViewController.h"
#import "pinyin.h"
@interface YMCosmetologistViewController ()

@end

@implementation YMCosmetologistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.viewNaviBar setAlpha:0];
    [self.viewNaviBar setTitle:@"美容师"];
    [self hiddenBackBtn:YES];
    // Do any additional setup after loading the view.
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
