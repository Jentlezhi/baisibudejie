//
//  NSObject+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/8.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font size:(CGSize)size{
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;
}

@end
