//
//  UIColor+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  十六进制颜色
 *
 *  @param hexColorString 十六进制数
 *  @param alpha          透明度
 *
 *  @return 颜色
 */
+ (instancetype)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;

+ (instancetype)colorWithHexColorString:(NSString *)hexColorString;


@end
