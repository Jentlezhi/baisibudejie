//
//  UIView+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "UIView+Extension.h"

static NSString *animationFnishKey = @"animationFnish";

@interface UIView()<CAAnimationDelegate>

@property(copy, nonatomic) void(^animationFnish)();

@end

@implementation UIView (Extension)

/**
 *  size的setter和getter方法
 */
-(void)setSize:(CGSize)aSize{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGSize)size{
    return self.frame.size;
}
/**
 *  origin的setter和getter方法
 */
- (void)setOrigin:(CGPoint)aOrigin{
    CGRect newframe = self.frame;
    newframe.origin = aOrigin;
    self.frame = newframe;
}

- (CGPoint)origin{
    return self.frame.origin;
}
/**
 *  width的setter和getter方法
 */
-(void)setWidth:(CGFloat)aWidth{
    CGRect newframe = self.frame;
    newframe.size.width = aWidth;
    self.frame = newframe;
}

- (CGFloat)width{
    return self.frame.size.width;
}

/**
 *  height的setter和getter方法
 */

- (void)setHeight:(CGFloat)aHeight{
    CGRect newframe = self.frame;
    newframe.size.height = aHeight;
    self.frame = newframe;
}

- (CGFloat)height{
    return self.frame.size.height;
}

/**
 *  x的setter和getter方法
 */

- (void)setX:(CGFloat)aX{
    CGRect newframe = self.frame;
    newframe.origin.x = aX;
    self.frame = newframe;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

/**
 *  y的setter和getter方法
 */
- (void)setY:(CGFloat)aY{
    CGRect newframe = self.frame;
    newframe.origin.y = aY;
    self.frame = newframe;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

/**
 *  centerX的setter和getter方法
 */

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

/**
 *  centerY的setter和getter方法
 */
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}

/**
 *  动态添加animationFnish属性
 */
- (void)setAnimationFnish:(void (^)())animationFnish{
    objc_setAssociatedObject(self, &animationFnishKey, animationFnish, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)())animationFnish{
    return objc_getAssociatedObject(self, &animationFnishKey);
}

- (void)rotationWithType:(BSAnimationRotationType)rotationType animationDuration:(CFTimeInterval)duration circle:(CGFloat)circle repaatCount:(float)repeatCount completion:(void (^ __nullable)())completion{
    NSString *keyPath = rotationType==BSAnimationRotationTypeUpdown?@"transform.rotation.x":@"transform.rotation.y";
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    rotationAnimation.delegate = self;
    rotationAnimation.removedOnCompletion = YES;
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * circle];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeatCount;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:rotationAnimation forKey:nil];
    self.animationFnish = !completion?nil:completion;

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    !self.animationFnish?:self.self.animationFnish();
}

- (void)animationWithImages:(NSArray *)images duration:(NSTimeInterval)duration repeatCount:(NSInteger)repeatCount{
    NSMutableArray *cgImages = [NSMutableArray array];
    for (UIImage *item in images) {
        CGImageRef cgImage = item.CGImage;
        [cgImages addObject:(__bridge UIImage *)cgImage];
    }
    CAKeyframeAnimation *imageAnimation = [CAKeyframeAnimation animation];
    imageAnimation.delegate = self;
    imageAnimation.keyPath = @"contents";
    imageAnimation.values = cgImages;
    imageAnimation.duration = duration;
    imageAnimation.repeatCount = repeatCount;
    imageAnimation.removedOnCompletion = YES;
    imageAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:imageAnimation forKey:nil];

}

- (BOOL)isVisibleOnKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}




@end
