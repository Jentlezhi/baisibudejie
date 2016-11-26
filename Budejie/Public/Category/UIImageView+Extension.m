//
//  UIImageView+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "UIImageView+Extension.h"


@implementation UIImageView (Extension)

+ (instancetype)roundWithImageView:(UIImageView *)imgv{
    if (imgv.size.width != imgv.size.height)return nil;
    imgv.layer.cornerRadius = imgv.width;
    imgv.layer.masksToBounds = YES;
    return imgv;
}
@end
