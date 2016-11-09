//
//  UIButton+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/8.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage{
   return [UIButton buttonWithBackgroundNormalImage:normalImage highlightImage:highlightImage target:nil action:nil];
}

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage{
    return [UIButton buttonWithNormalImage:normalImage highlightImage:highlightImage target:nil action:nil];
}

- (instancetype)setTitleColorWithNormalColor:(UIColor *)normalColor  highlightColor:(UIColor *)highlightColor{
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
    return self;
}

@end
