//
//  NSObject+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/8.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
/**
 *  自动计算字符串size
 *
 *  @param string 字符串
 *  @param font   字体
 *  @param size   size限制
 *
 *  @return 字符串尺寸
 */
- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font size:(CGSize)size;

@end
