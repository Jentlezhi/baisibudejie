//
//  UIImageView+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
/**
 *  图片裁剪为圆
 *
 *  @param imgv 图片
 *
 *  @return 裁剪后的图片
 */
+ (instancetype)roundWithImageView:(UIImageView *)imgv;

@end
