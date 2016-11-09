//
//  BSMineViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSMineViewController.h"

@implementation BSMineViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self mineBasicConfig];
    [self mineInitComponents];

}

/**
 *  基本配置
 */
- (void)mineBasicConfig{
    [self createNavBarWithTitle:@"我的"];
}
/**
 *  初始化子控件
 */
- (void)mineInitComponents{
    
    //设置按钮
    UIButton *settingBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"]];
    CGFloat settingBtnW = settingBtn.currentBackgroundImage.size.width;
    CGFloat settingBtnH = settingBtn.currentBackgroundImage.size.height;
    CGFloat settingBtnX = self.navigationBar.width-settingBtnW-BSMarigin;
    CGFloat settingBtnY = (self.navigationBar.height-settingBtnH)*0.5;
    settingBtn.frame = CGRectMake(settingBtnX , settingBtnY, settingBtnW, settingBtnH);
    [[settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSLogCyan(@"%s",__func__);
    }];
    [self.navigationBar addSubview:settingBtn];
    
    //夜间模式按钮
    UIButton *nightBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"mine-moon-icon"] highlightImage:[UIImage imageNamed:@"mine-moon-icon-click"]];
    CGFloat nightBtnW = settingBtn.currentBackgroundImage.size.width;
    CGFloat nightBtnH = settingBtn.currentBackgroundImage.size.height;
    CGFloat nightBtnX = self.navigationBar.width-settingBtnW-nightBtnW-2*BSMarigin;
    CGFloat nightBtnY = (self.navigationBar.height-settingBtnH)*0.5;
    nightBtn.frame = CGRectMake(nightBtnX , nightBtnY, nightBtnW, nightBtnH);
    [[nightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSLogCyan(@"%s",__func__);
    }];
    [self.navigationBar addSubview:nightBtn];
    
}


@end
