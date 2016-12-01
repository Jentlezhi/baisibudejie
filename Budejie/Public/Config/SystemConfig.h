//
//  SystemConfig.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#ifndef SystemConfig_h
#define SystemConfig_h

//当前系统
#define BSCurrentIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//判断系统是否为x.x
#define BSIsIOS(x)       (TTCurrentIOSVersion >= (int)x && TTCurrentIOSVersion < (int)x+1)

//设备判断
#define BSIsiPhone4S     ([UIScreen mainScreen].bounds.size.height == 480.0)
#define BSIsiPhone5      ([UIScreen mainScreen].bounds.size.height == 568.0)
#define BSIsiPhone6      ([UIScreen mainScreen].bounds.size.width == 375.0)
#define BSIsiPhone6P     ([UIScreen mainScreen].bounds.size.width == 414.0)

//屏幕尺寸
#define kScreenBounds     ([UIScreen mainScreen].bounds)
#define kScreenWidth      (kScreenBounds.size.width)
#define kScreenHeight     (kScreenBounds.size.height)

//系统Application
#define BSSharedApplication     [UIApplication sharedApplication]
//导航条高度
#define BSNavigationBarHeight  44.f
//tabBar高度
#define BSTabBarHeight         49.f
//状态栏高度
#define BSStatusBarHeight [BSSharedApplication statusBarFrame].size.height
//自动提示宏
#define BSAutoAttr(objc,kPath) @(((void)objc.kPath,#kPath))
//自动布局
#define BSALayoutH(x)    ((x) * kScreenWidth/750.0)
#define BSALayoutV(y)    ((y) * kScreenHeight/1334.0)

//点击tabBar
#define BSTabBarDidSelectNotification @"BSTabBarDidSelectNotification"

//根视图控制器
#define BSRootViewController  [UIApplication sharedApplication].keyWindow.rootViewController

//通知中心
#define BSNotificationCenter  [NSNotificationCenter defaultCenter]

#endif /* SystemConfig_h */
