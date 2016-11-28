//
//  UIImage+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据颜色返回图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return 返回指定颜色和大小的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color imageSize:(CGSize)size;

/**
 *  根据颜色返回指定的大小的图片
 *
 *  @param color 图片颜色
 *
 *  @return 返回指定颜色1个点的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color;
/**
 *  图片渲染
 *
 *  @param image 原图片
 *  @param color 渲染颜色
 *
 *  @return 渲染后图片
 */
+ (instancetype)image:(UIImage *)image withTintColor:(UIColor *)color;

/**
 *  圆形带有环图片
 *
 *  @param borderWidth 圆环宽度
 *  @param borderColor 圆环颜色
 *
 *  @return 渲染后图片
 */
- (instancetype)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
