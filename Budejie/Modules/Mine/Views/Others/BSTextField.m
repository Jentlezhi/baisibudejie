//
//  BSTextField.m
//  Budejie
//
//  Created by Jentle on 2016/11/15.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTextField.h"

static NSString * const BSPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation BSTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:BSPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:BSPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
