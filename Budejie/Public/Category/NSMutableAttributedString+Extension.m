//
//  NSMutableAttributedString+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+ (NSMutableAttributedString *)stringwithContent:(NSString *)content desContent:(NSString *)desContent fontSize:(CGFloat)aSize textColor:(UIColor *)aColor {
    if (!content)return nil;
    NSRange range = [content rangeOfString:desContent];
    if (range.length == NSNotFound) return nil;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:content];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:aSize] range:range];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:aColor range:range];
    return attributeStr;
}


@end
