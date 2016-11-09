//
//  BSBaseViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseViewController.h"

static CGFloat const TTMarigin = 10;

@interface BSBaseViewController()
/** 状态栏 */
@property(weak, nonatomic) UIImageView *statusBar;
/** 导航栏标题 */
@property(weak, nonatomic) UILabel *navTitleLabel;
/** 导航栏分割线 */
@property(weak, nonatomic) UILabel *dividerLine;

@end

@implementation BSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfig];
    [self initComponents];
    
}

/**
 *  基本配置
 */
- (void)basicConfig{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
/**
 *  初始化子控件
 */
- (void)initComponents{
    //状态栏
    UIImageView *statusBar = [[UIImageView alloc] init];
    statusBar.frame = CGRectMake(0, 0, kScreenWidth, BSStatusBarHeight);
    [self.view addSubview:statusBar];
    _statusBar = statusBar;
    
    //导航栏
    UIImageView *navigationBar = [[UIImageView alloc] init];
    navigationBar.frame = CGRectMake(0, CGRectGetMaxY(statusBar.frame), kScreenWidth, BSNavigationBarHeight);
    [self.view addSubview:navigationBar];
    _navigationBar = navigationBar;
    
    //导航栏分割线
    UILabel *dividerLine = [[UILabel alloc] init];
    dividerLine.backgroundColor = [UIColor lightGrayColor];
    CGFloat dividerLineW = kScreenWidth;
    CGFloat dividerLineH = 0.5;
    CGFloat dividerLineX = 0;
    CGFloat dividerLineY = BSNavigationBarHeight-dividerLineH;
    dividerLine.frame = CGRectMake(dividerLineX , dividerLineY, dividerLineW, dividerLineH);
    [_navigationBar addSubview:dividerLine];
    _dividerLine = dividerLine;
    
    //导航栏标题
    UILabel *navTitleLabel = [[UILabel alloc] init];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    CGFloat navTitleLabelX = kScreenWidth/3;
    CGFloat navTitleLabelY = 0;
    CGFloat navTitleLabelW = kScreenWidth/3;
    CGFloat navTitleLabelH = BSNavigationBarHeight;
    navTitleLabel.frame = CGRectMake(navTitleLabelX , navTitleLabelY, navTitleLabelW, navTitleLabelH);
    [_navigationBar addSubview:navTitleLabel];
    _navTitleLabel = navTitleLabel;
    
}
/**
 *  控件默认设置
 */
- (void)defaultSetting{
    [self statusBarDefaultSetting];
    [self navigationBarDefaultSetting];
    [self navTitleDefaultSetting];
}

/**
 * statusBarColor的setter方法
 */
- (void)setStatusBarColor:(UIColor *)statusBarColor{
    _statusBarColor = statusBarColor;
    _statusBar.backgroundColor = statusBarColor;
}
/**
 * navigationBarColor的setter方法
 */
- (void)setNavigationBarColor:(UIColor *)navigationBarColor{
    _navigationBarColor = navigationBarColor;
    _navigationBar.backgroundColor = navigationBarColor;
}
/**
 * hiddenNavigationBarLine的setter方法
 */
- (void)setHiddenNavigationBarLine:(BOOL)hiddenNavigationBarLine{
    _dividerLine.hidden = hiddenNavigationBarLine;
}

/**
 *  状态栏默认设置
 */

- (void)navigationBarDefaultSetting{
    _navigationBar.backgroundColor = [UIColor whiteColor];
}

/**
 *  导航栏默认设置
 */

- (void)statusBarDefaultSetting{
    _statusBar.backgroundColor = [UIColor whiteColor];
}

/**
 *  导航栏标题默认设置
 */

- (void)navTitleDefaultSetting{
    [self settingNavTitleWithTitle:nil fontSize:18 textColor:[UIColor blackColor]];
}

- (void)settingNavTitleWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor{
    _navTitleLabel.text = title;
    _navTitleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    _navTitleLabel.textColor = textColor;
}
/**
 * public
 */
- (void)createNavBarWithTitle:(NSString *)tittle andShowBackButton:(BOOL)isShowBackButton showRightButton:(BOOL)isShowRightButton withRightButtonTitle:(NSString *)rightButtonTitle{
    _navTitleLabel.text = tittle;
    if (isShowBackButton) {
        //返回按钮
        NSString *bundlePath = [[ NSBundle mainBundle] pathForResource: @"BSBaseViewController" ofType :@"bundle"];
        UIImage *backImage = [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"back.png"]];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:backImage forState:UIControlStateNormal];
        
        CGFloat backButtonW = 17;
        CGFloat backButtonH = 33;
        CGFloat backButtonX = TTMarigin;
        CGFloat backButtonY = (BSNavigationBarHeight - backButtonH)*0.5;
        backButton.frame = CGRectMake(backButtonX , backButtonY, backButtonW, backButtonH);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationBar addSubview:backButton];
    }
    
    if (isShowRightButton) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        CGFloat rightButtonW = 17*2;
        CGFloat rightButtonH = BSNavigationBarHeight;
        CGFloat rightButtonX = kScreenWidth-TTMarigin-rightButtonW;
        CGFloat rightButtonY = 0;
        rightButton.frame = CGRectMake(rightButtonX , rightButtonY, rightButtonW, rightButtonH );
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationBar addSubview:rightButton];
    }
}

- (void)createNavBarWithTitle:(NSString *)tittle andShowBackButton:(BOOL)isShowBackButton{
    [self createNavBarWithTitle:tittle andShowBackButton:isShowBackButton showRightButton:NO withRightButtonTitle:nil];
}

/**
 *  返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  右边按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    
}


@end
