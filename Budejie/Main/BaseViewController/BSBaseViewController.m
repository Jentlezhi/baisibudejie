//
//  BSBaseViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BSBaseViewController()
/** 状态栏 */
@property(strong, nonatomic) UIImageView *statusBar;
/** 导航栏标题 */
@property(strong, nonatomic) UILabel *navTitleLabel;
/** 导航栏图片 */
@property(strong, nonatomic) UIImageView *navTitleView;
/** 导航栏分割线 */
@property(strong, nonatomic) UILabel *dividerLine;


@end

@implementation BSBaseViewController
/**
 *  状态栏
 */
- (UIImageView *)statusBar{
    if (!_statusBar) {
        _statusBar = [[UIImageView alloc] init];
        _statusBar.userInteractionEnabled = YES;
        _statusBar.frame = CGRectMake(0, 0, kScreenWidth, BSStatusBarHeight);
    }
    return _statusBar;
}
/**
 *  状态栏
 */
- (UIImageView *)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [[UIImageView alloc] init];
        _navigationBar.userInteractionEnabled = YES;
        _navigationBar.frame = CGRectMake(0, CGRectGetMaxY(self.statusBar.frame), kScreenWidth, BSNavigationBarHeight);
    }
    return _navigationBar;
}
/**
 *  导航栏标题
 */
- (UILabel *)navTitleLabel{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.userInteractionEnabled = YES;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.backgroundColor = [UIColor clearColor];
        _navTitleLabel.font = BSNavTitleFont;
        _navTitleLabel.textColor = BSRGBColor(1, 1, 1);
        CGFloat navTitleLabelX = kScreenWidth/3;
        CGFloat navTitleLabelY = 0;
        CGFloat navTitleLabelW = kScreenWidth/3;
        CGFloat navTitleLabelH = BSNavigationBarHeight;
        _navTitleLabel.frame = CGRectMake(navTitleLabelX , navTitleLabelY, navTitleLabelW, navTitleLabelH);
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
        [_navTitleLabel addGestureRecognizer:titleTap];
    }
    return _navTitleLabel;
}
/**
 *  导航栏分割线
 */
- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [[UILabel alloc] init];
        _dividerLine.backgroundColor = [UIColor lightGrayColor];
        CGFloat dividerLineW = kScreenWidth;
        CGFloat dividerLineH = 0.2;
        CGFloat dividerLineX = 0;
        CGFloat dividerLineY = BSNavigationBarHeight-dividerLineH;
        _dividerLine.frame = CGRectMake(dividerLineX , dividerLineY, dividerLineW, dividerLineH);
    }
    return _dividerLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseBasicConfig];
    [self baseInitComponents];
    [self baseDefaultSetting];
}

/**
 *  基本配置
 */
- (void)baseBasicConfig{
    self.view.backgroundColor = BSGlobalCoolor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
/**
 *  初始化子控件
 */
- (void)baseInitComponents{
    //状态栏
    [self.view addSubview:self.statusBar];
    
    //导航栏
    [self.view addSubview:self.navigationBar];
    
    //导航栏分割线
    [self.navigationBar addSubview:self.dividerLine];
    
}
/**
 *  控件默认设置
 */
- (void)baseDefaultSetting{
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
    _navigationBar.image = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
}

/**
 *  导航栏默认设置
 */

- (void)statusBarDefaultSetting{
    _statusBar.image = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
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
 *  自定义标题导航栏
 *
 *  @param tittle           导航栏标题
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮的标题（传空默认不显示）
 */
- (void)createNavBarWithTitle:(NSString *)tittle andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle{
    //导航栏标题
    if (tittle.length != 0) {
        self.navTitleLabel.text = tittle;
        [_navigationBar addSubview:self.navTitleLabel];
    }
    if (isShowBackButton) {
        //返回按钮
        UIButton *backButton = [UIButton buttonWithNormalImage:[UIImage imageNamed:@"navigationButtonReturn"] highlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"]];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [backButton setTitleColorWithNormalColor:BSRGBColor(1, 1, 1) highlightColor:BSRGBColor(251, 32, 36)];
        CGFloat backButtonW = 15+17*2;
        CGFloat backButtonH = 21;
        CGFloat backButtonX = BSMarigin;
        CGFloat backButtonY = (BSNavigationBarHeight - backButtonH)*0.5;
        backButton.frame = CGRectMake(backButtonX , backButtonY, backButtonW, backButtonH);
//        [backButton sizeToFit];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationBar addSubview:backButton];
    }
    
    if (rightButtonTitle.length != 0) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        CGFloat rightButtonW = 17*2;
        CGFloat rightButtonH = BSNavigationBarHeight;
        CGFloat rightButtonX = kScreenWidth-BSMarigin-rightButtonW;
        CGFloat rightButtonY = 0;
        rightButton.frame = CGRectMake(rightButtonX, rightButtonY,rightButtonW, rightButtonH);
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationBar addSubview:rightButton];
    }
}

/**
 *  创建隐藏左、右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithTitle:(NSString *)tittle{
    [self createNavBarWithTitle:tittle andShowBackButton:NO showRightButtonWithTitle:nil];
}

/**
 *  创建隐藏右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitle:(NSString *)tittle{
    [self createNavBarWithTitle:tittle andShowBackButton:YES showRightButtonWithTitle:nil];
}
/**
 *  创建图片导航栏
 *
 *  @param tittleImage      导航栏图片
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮标题（传空默认不显示）
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage  andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle{
    [self createNavBarWithTitle:nil andShowBackButton:isShowBackButton showRightButtonWithTitle:rightButtonTitle];
    if (!tittleImage)return;
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.userInteractionEnabled = YES;
    titleView.image = [tittleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
    [titleView addGestureRecognizer:titleTap];
    [_navigationBar addSubview:titleView];
}

/**
 *  创建隐藏左、右按钮的图片导航栏
 *
 *  @param tittleImage 标题图片
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage{
    [self createNavBarWithTitleView:tittleImage andShowBackButton:NO showRightButtonWithTitle:nil];
}
/**
 *  创建隐藏右按钮的图片导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitleView:(UIImage *)tittleImage{
        [self createNavBarWithTitleView:tittleImage andShowBackButton:YES showRightButtonWithTitle:nil];
}
/**
 *  创建自定义按钮的导航栏
 *
 *  @param leftButtons  左按钮
 *  @param titleButton 标题按钮
 *  @param rightButtons 右按钮
 */
- (void)createNavBarWithLeftButton:(UIButton *)leftButton titleView:(UIView *)titleView andRightButton:(UIButton *)rightButton{
    if (leftButton) {
        //左按钮frame
        CGFloat leftButtonW = leftButton.currentBackgroundImage.size.width;
        CGFloat leftButtonH = leftButton.currentBackgroundImage.size.height;
        CGFloat leftButtonX = BSMarigin;
        CGFloat leftButtonY = (self.navigationBar.height - leftButtonH)*0.5;
        leftButton.frame = CGRectMake(leftButtonX , leftButtonY, leftButtonW, leftButtonH);
        [_navigationBar addSubview:leftButton];
        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (titleView) {
        //添加手势
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
        //标题按钮frame
        CGFloat titleButtonW = 0.f;
        CGFloat titleButtonH = 0.f;
        if ([titleView isKindOfClass:[UIButton class]]) {
            UIButton *titleButton = (UIButton *)titleView;
            titleButtonW = titleButton.currentBackgroundImage.size.width;
            titleButtonH = titleButton.currentBackgroundImage.size.height;
          [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([titleView isKindOfClass:[UILabel class]]){
            UILabel *titleButton = (UILabel *)titleView;
            titleButton.font = BSNavTitleFont;
            titleButton.userInteractionEnabled = YES;
            titleButtonW = [self sizeForString:titleButton.text font:titleButton.font size:CGSizeMake(CGFLOAT_MAX, titleButtonH)].width;
            titleButtonH = titleButton.font.pointSize;
            [titleButton addGestureRecognizer:titleTap];
        }else if ([titleView isKindOfClass:[UIImageView class]]){
            UIImageView *titleButton = (UIImageView *)titleView;
            titleButton.userInteractionEnabled = YES;
            titleButtonW = titleButton.image.size.width;
            titleButtonH = titleButton.image.size.height;
            [titleButton addGestureRecognizer:titleTap];
        }
        
        CGFloat titleButtonX = (_navigationBar.width-titleButtonW)*0.5;
        CGFloat titleButtonY = (_navigationBar.height-titleButtonH)*0.5;
        titleView.frame = CGRectMake(titleButtonX , titleButtonY, titleButtonW, titleButtonH);
        [_navigationBar addSubview:titleView];

    }
    
    if (rightButton) {
        //右按钮frame
        CGFloat rightButtonW = rightButton.currentBackgroundImage.size.width;
        CGFloat rightButtonH = rightButton.currentBackgroundImage.size.height;
        CGFloat rightButtonX = self.navigationBar.width-rightButtonW-BSMarigin;
        CGFloat rightButtonY = (self.navigationBar.height - rightButtonH)*0.5;
        rightButton.frame = CGRectMake(rightButtonX , rightButtonY, rightButtonW, rightButtonH);
        [_navigationBar addSubview:rightButton];
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }

}

/**
 *  返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  左边按钮的点击
 */
- (void)leftButtonClick:(UIButton *)rightButton{
    
}

/**
 *  标题按钮的点击
 */
- (void)titleButtonClick:(UIButton *)rightButton{
    
}

/**
 *  右边按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    
}
/**
 *  取消网络请求任务
 */
- (void)cancelRequest{
    [self.sessionDateTask cancel];
}
/**
 *  控制器销毁，取消所有请求
 */
- (void)dealloc{
    [self cancelRequest];
    
}

@end
