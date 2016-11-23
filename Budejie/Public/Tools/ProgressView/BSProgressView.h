//
//  BSProgressView.h
//  Budejie
//
//  Created by Jentle on 2016/11/22.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <M13ProgressViewRing.h>

@interface BSProgressView : M13ProgressViewRing
/** 外圈颜色 */
@property(strong, nonatomic) UIColor *circleColor;
/** 进度颜色 */
@property(strong, nonatomic) UIColor *progressColor;
/** 进度值 */
@property(assign, nonatomic) CGFloat progressValue;


@end
