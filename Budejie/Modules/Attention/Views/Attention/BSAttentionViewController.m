//
//  BSAttentionViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSAttentionViewController.h"
#import "BSRecommendViewController.h"
#import "BSUserGroupNetworkTool.h"


@interface BSAttentionViewController()

/** 未登录视图 */
@property(weak, nonatomic) UIView *notLoginView;

@end

@implementation BSAttentionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self attentionBasicConfig];
    [self attentionInitComponents];
}

/**
 *  基本配置
 */
- (void)attentionBasicConfig{
    //左按钮
    UIButton *leftButton = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"]];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSRecommendViewController *recommendVC = [BSRecommendViewController recommendViewController];
        [self.navigationController pushViewController:recommendVC animated:YES];
    }];
    
    //标题按钮
    UILabel *titleButton = [[UILabel alloc] init];
    titleButton.text = @"我的关注";
    [self createNavBarWithLeftButton:leftButton titleView:titleButton andRightButton:nil];
}

/**
 *  初始化子控件
 */
- (void)attentionInitComponents{
    //未登录视图
    UIView *notLoginView = [[UIView alloc] init];
    notLoginView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:notLoginView];
    _notLoginView = notLoginView;
    [notLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).equalTo(64);
    }];
    
    //header
    UIImageView *headerCry = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_cry_icon"]];
    [_notLoginView addSubview:headerCry];
    [headerCry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-BSALayoutV(40)-headerCry.image.size.height);
        make.centerX.equalTo(self.view);
    }];
    //提示文字
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:17.0f];
    tipLabel.textColor = BSRGBColor(152, 102, 51);
    tipLabel.text = @"快快登录吧, 关注百思最in牛人\n好友动态让你过把瘾儿~\n欧耶~~~~!";
    tipLabel.numberOfLines = 0;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [_notLoginView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    //立即登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitleColor:BSRGBColor(220, 66, 55) forState:UIControlStateNormal];
    [loginBtn setTitleColor:BSRGBColor(255, 255, 255) forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"立即登录注册" forState:UIControlStateNormal];
    loginBtn.adjustsImageWhenHighlighted = NO;
    [_notLoginView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(loginBtn.currentBackgroundImage.size.width, loginBtn.currentBackgroundImage.size.height));
        make.top.equalTo(tipLabel.mas_bottom).offset(BSALayoutV(40));
        make.centerX.equalTo(tipLabel);
    }];
    
}
@end
