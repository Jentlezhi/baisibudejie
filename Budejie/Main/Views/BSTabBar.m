//
//  BSTabBar.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTabBar.h"

@interface BSTabBar()

/** 发布按钮 */
@property(weak, nonatomic) UIButton *publishButton;

@end

@implementation BSTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置tabBar背景
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [[publishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (self.publishBtnClicked) {
                self.publishBtnClicked();
            }
        }];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //发布按钮frame
    _publishButton.bounds = CGRectMake(0, 0, _publishButton.currentBackgroundImage.size.width, _publishButton.currentBackgroundImage.size.height);
    _publishButton.center = CGPointMake(self.width*0.5, self.height*0.5);
    //其他按钮的frame
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
            buttonX = index>1?(index+1)*buttonW:index*buttonW;
            button.frame = CGRectMake(buttonX , buttonY, buttonW, buttonH);
        index++;
    }
}

@end
