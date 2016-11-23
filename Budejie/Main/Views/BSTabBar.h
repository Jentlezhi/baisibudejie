//
//  BSTabBar.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTabBar : UITabBar

@property(copy, nonatomic) void(^publishBtnClicked)();

@end
