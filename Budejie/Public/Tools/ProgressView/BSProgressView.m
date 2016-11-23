//
//  BSProgressView.m
//  Budejie
//
//  Created by Jentle on 2016/11/22.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSProgressView.h"

@implementation BSProgressView
- (void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    self.primaryColor = circleColor;
    
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.secondaryColor = progressColor;
}

- (void)setProgressValue:(CGFloat )progressValue{
    progressValue = progressValue<=0.0 ?0:progressValue;
    _progressValue = progressValue;
    [self setProgress:progressValue animated:NO];
}





@end
