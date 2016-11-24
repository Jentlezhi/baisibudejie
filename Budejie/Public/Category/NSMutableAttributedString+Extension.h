//
//  NSMutableAttributedString+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Extension)

+ (NSMutableAttributedString *)stringwithContent:(NSString *)content desContent:(NSString *)desContent fontSize:(CGFloat)aSize textColor:(UIColor *)aColor;

@end
