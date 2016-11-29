//
//  UIView+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BSAnimationRotationTypeUpdown = 0,
    BSAnimationRotationTypeLeftRight
} BSAnimationRotationType;

@interface UIView (Extension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)rotationWithType:(BSAnimationRotationType)rotationType animationDuration:(CFTimeInterval)duration circle:(CGFloat)circle repaatCount:(float)repeatCount completion:(void (^ __nullable)())completion;

- (void)animationWithImages:(NSArray *)images duration:(NSTimeInterval)duration repeatCount:(NSInteger)repeatCount;

- (BOOL)isVisibleOnKeyWindow;

@end
