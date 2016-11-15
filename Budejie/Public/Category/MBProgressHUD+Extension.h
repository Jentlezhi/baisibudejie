//
//  MBProgressHUD+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)
/**
 *  显示加载框
 *
 *  @param message 加载描述
 */
+ (void)showMessage:(NSString *)message;
/**
 *  显示加载框
 *
 *  @param view    父视图
 *  @param message 加载描述
 */
+ (void)showInView:(UIView *)view withMessage:(NSString *)message;
/**
 *  显示加载框
 *
 *  @param view    父视图
 *  @param frame   尺寸
 *  @param message 加载描述
 */
+ (void)showInView:(UIView *)view frame:(CGRect)frame withMessage:(NSString *)message;
/**
 *  操作成功提示
 *  @param message 加载描述
 */
+ (void)showSuccessWithMessage:(NSString *)message;
/**
 *  操作失败提示
 *  @param message 加载描述
 */
+ (void)showErrorWithMessage:(NSString *)message;
/**
 *  操作警告提示
 *  @param message 加载描述
 */
+ (void)showWarringWithMessage:(NSString *)message;
/**
 *  移除加载框
 */
+ (void)hidden;

@end
