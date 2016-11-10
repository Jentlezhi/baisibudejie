//
//  BSBaseViewController.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSBaseViewController : UIViewController
/** 状态栏颜色 */
@property(strong, nonatomic) UIColor *statusBarColor;
/** 导航栏颜色 */
@property(strong, nonatomic) UIColor *navigationBarColor;
/** 导航栏 */
@property(strong, nonatomic) UIImageView *navigationBar;
/** 是否隐藏导航栏分割线 */
@property(assign, nonatomic) BOOL hiddenNavigationBarLine;
/** 网络请求 */
@property(strong, nonatomic) NSURLSessionDataTask *sessionDateTask;
/**
 *  设置导航栏标题
 *
 *  @param title     标题
 *  @param fontSize  字体大小
 *  @param textColor 字体颜色
 */
- (void)settingNavTitleWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor;
/**
 *  自定义标题导航栏
 *
 *  @param tittle           导航栏标题
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮的标题（传空默认不显示）
 */
- (void)createNavBarWithTitle:(NSString *)tittle andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle;
/**
 *  创建隐藏左、右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithTitle:(NSString *)tittle;
/**
 *  创建隐藏右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitle:(NSString *)tittle;
/**
 *  创建图片导航栏
 *
 *  @param tittleImage      导航栏图片
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮标题（传空默认不显示）
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle;
/**
 *  创建隐藏左、右按钮的图片导航栏
 *
 *  @param tittleImage 标题图片
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage;
/**
 *  创建隐藏右按钮的图片导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitleView:(UIImage *)tittleImage;
/**
 *  创建自定义按钮的导航栏
 *
 *  @param leftButton  左按钮
 *  @param titleButton 标题按钮
 *  @param rightButton 右按钮
 */
- (void)createNavBarWithLeftButton:(UIButton *)leftButton titleView:(UIView *)titleView andRightButton:(UIButton *)rightButton;
/**
 *  返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton;

/**
 *  左边按钮的点击
 */
- (void)leftButtonClick:(UIButton *)rightButton;

/**
 *  标题按钮的点击
 */
- (void)titleButtonClick:(UIButton *)rightButton;

/**
 *  右边按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton;

/**
 *  取消网络请求任务
 */
- (void)cancelRequest;


@end
