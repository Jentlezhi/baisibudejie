//
//  BSNavigationController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSNavigationController.h"

@implementation BSNavigationController

+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    bar.hidden = YES;
}

/**
 *  viewDidLoad方法调用次数为控制器个数
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfig];
    
    
}
/**
 *  基本配置
 */
- (void)basicConfig{
    self.navigationBar.hidden = YES;
    
    
}
/**
 *  push到次级页面隐藏bottomBar
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
