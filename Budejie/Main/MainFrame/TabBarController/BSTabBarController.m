//
//  BSTabBarController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTabBarController.h"
#import "BSNavigationController.h"
#import "BSEssenceViewController.h"
#import "BSNewestViewController.h"
#import "BSAttentionViewController.h"
#import "BSMineViewController.h"
#import "BSPublishView.h"
#import "BSTabBar.h"

//TabBar文字颜色
#define kTabBarNormalFontColor   [UIColor lightGrayColor]
#define kTabBarSelectedFontColor [UIColor darkGrayColor]

@interface BSTabBarController()

@property(strong, nonatomic) BSTabBar *myTabBar;

@end

@implementation BSTabBarController

- (BSTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[BSTabBar alloc] init];
    }
    return _myTabBar;
}

+ (void)load{
    //修改按钮文字
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTabBarSelectedFontColor,                                                                                                    NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTabBarNormalFontColor,                                                                                                    NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self publishButtonClick];
    [self createSubViewControllers];
    [self reloadImage];
}

- (void)publishButtonClick{
    self.myTabBar.publishBtnClicked = ^{
        [BSPublishView show];
    };
}


- (void)createSubViewControllers{
    
    //精华
    BSEssenceViewController *essenceVC = [[BSEssenceViewController alloc] init];
    BSNavigationController *essenceNav = [[BSNavigationController alloc] initWithRootViewController:essenceVC];
    
    //最新
    BSNewestViewController *newestVC = [[BSNewestViewController alloc] init];
    BSNavigationController *newestNav = [[BSNavigationController alloc] initWithRootViewController:newestVC];
    
    //关注
    BSAttentionViewController *attentionVC = [[BSAttentionViewController alloc] init];
    BSNavigationController *attentionNav = [[BSNavigationController alloc] initWithRootViewController:attentionVC];
    
    //我
    BSMineViewController *mineVC = [[BSMineViewController alloc] init];
    BSNavigationController *mineNav = [[BSNavigationController alloc] initWithRootViewController:mineVC];
    
    
    self.viewControllers = [NSArray arrayWithObjects:
                                           essenceNav,
                                           newestNav,
                                           attentionNav,
                                           mineNav,
                                           nil];
}

- (void)reloadImage{
    NSArray *viewControllerArray = self.viewControllers;
    NSMutableArray *arrayDore = [NSMutableArray new];
    
    [viewControllerArray enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
     {
         UITabBarItem *item = nil;
         
         switch (idx)
         {
             case 0:
             {
                 item = [[UITabBarItem alloc] initWithTitle:@"精华" image:[[UIImage imageNamed:@"tabBar_essence_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_essence_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 break;
             }
             case 1:
             {
                 item = [[UITabBarItem alloc] initWithTitle:@"最新" image:nil tag:1];
                 [item setImage:[[UIImage imageNamed:@"tabBar_new_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 [item setSelectedImage:[[UIImage imageNamed:@"tabBar_new_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 break;
             }
             case 2:
             {
                 item = [[UITabBarItem alloc] initWithTitle:@"关注" image:nil tag:1];
                 [item setImage:[[UIImage imageNamed:@"tabBar_friendTrends_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 [item setSelectedImage:[[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 break;
             }
             case 3:
             {
                 item = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:1];
                 [item setImage:[[UIImage imageNamed:@"tabBar_me_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 [item setSelectedImage:[[UIImage imageNamed:@"tabBar_me_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 break;
             }
         }
         viewController.tabBarItem = item;
         
         UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
         [bar setBackgroundImage:[UIImage imageNamed:@"MainTitle"] forBarMetrics:UIBarMetricsDefault];

         [arrayDore addObject:viewController];
     }];

    self.viewControllers = arrayDore;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    //替换系统tabBar
    [self setValue:self.myTabBar forKeyPath:@"tabBar"];

}

@end
