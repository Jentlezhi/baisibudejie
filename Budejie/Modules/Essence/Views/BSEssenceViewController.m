//
//  BSEssenceViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSTestViewController.h"

@implementation BSEssenceViewController



- (void)viewDidLoad{
    [super viewDidLoad];
    [self essenceBasicConfig];
    [self initEssenceComponents];
}
/**
 *  基本配置
 */
- (void)essenceBasicConfig{

}

/**
 *  初始化子控件
 */
- (void)initEssenceComponents{
    //左按钮
    UIButton *leftButton = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"]];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController pushViewController:[[BSTestViewController alloc] init]animated:YES];
    }];
    //标题按钮
    UIImageView *titleButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self createNavBarWithLeftButton:leftButton titleView:titleButton andRightButton:nil];
}


@end
