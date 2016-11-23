//
//  MBProgressHUD+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

static MBProgressHUD *hud = nil;

@implementation MBProgressHUD (Extension)

+ (void)showMessage:(NSString *)message{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [MBProgressHUD showInView:window withMessage:message];
    
}

+ (void)showInView:(UIView *)view withMessage:(NSString *)message{
    CGRect frame = view.bounds;
    frame.origin.y += 64;
    frame.size.height-=64;
    [MBProgressHUD showInView:view frame:frame withMessage:message];
}

+ (void)showInView:(UIView *)view frame:(CGRect)frame withMessage:(NSString *)message{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    view = view == nil?window:view;
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.frame = frame;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.mode = MBProgressHUDModeIndeterminate;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.3;
    effectView.frame = hud.bounds;
    [hud.backgroundView insertSubview:effectView atIndex:0];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.margin = 12.f;
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showSuccessWithMessage:(NSString *)message{
    [MBProgressHUD showWithStatusImage:[UIImage imageNamed:@"success"] Message:message];
}

+ (void)showErrorWithMessage:(NSString *)message{
    [MBProgressHUD showWithStatusImage:[UIImage imageNamed:@"error"] Message:message];
}

+ (void)showWarringWithMessage:(NSString *)message{
    [MBProgressHUD showWithStatusImage:[UIImage imageNamed:@"info"] Message:message];
}

+ (void)showWithStatusImage:(UIImage *)image  Message:(NSString *)message{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:12];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage image:image withTintColor:[UIColor whiteColor]]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.3f;
    effectView.frame = hud.bounds;
    [hud.backgroundView insertSubview:effectView atIndex:0];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5f];
}

+ (void)hidden{
    [hud removeFromSuperview];
}

@end
