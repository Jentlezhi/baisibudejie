//
//  BSPushGuidView.m
//  Budejie
//
//  Created by Jentle on 2016/11/16.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSPushGuidView.h"

@implementation BSPushGuidView

+ (instancetype)pushGuidView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        //两次版本不一样
        //显示推送引导
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        BSPushGuidView *guideView = [BSPushGuidView pushGuidView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        //存储本次版本信息
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
- (IBAction)dismiss {
    [self removeFromSuperview];
}



@end
