//
//  UIButton+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/8.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *  @param target         SEL目标
 *  @param action         按钮点击行为
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *  @param action         按钮点击行为
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage;
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *  @param target         SEL目标
 *  @param action         按钮点击行为
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage;
/**
 *  设置状态颜色
 *
 *  @param normalColor    普通状态下颜色
 *  @param highlightColor 高亮状态下颜色
 *
 *  @return 该按钮
 */
- (instancetype)setTitleColorWithNormalColor:(UIColor *)normalColor  highlightColor:(UIColor *)highlightColor;

@end
