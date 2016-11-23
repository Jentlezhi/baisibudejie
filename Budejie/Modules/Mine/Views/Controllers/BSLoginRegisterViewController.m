//
//  BSLoginRegisterViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/15.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSLoginRegisterViewController.h"

@interface BSLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeading;

@end

@implementation BSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginRegisterBasicConfig];
    [self loginRegisterInitComponents];
}
/**
 *  基本配置
 */
- (void)loginRegisterBasicConfig{
    self.navigationZone.hidden = YES;
}
/**
 *  初始化子控件
 */
- (void)loginRegisterInitComponents{
    
}
/**
 *  修改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)dismiss {
    // 退出键盘
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showRegisteView:(UIButton *)sender {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginLeading.constant == 0) { // 显示注册界面
        self.loginLeading.constant = - self.view.width;
        sender.selected = YES;
    } else { // 显示登录界面
        self.loginLeading.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
