//
//  BSVerticalButton.m
//  Budejie
//
//  Created by Jentle on 2016/11/15.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSVerticalButton.h"

@implementation BSVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + self.contentMargin;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setContentMargin:(CGFloat)contentMargin{
    _contentMargin = contentMargin;
    [self layoutIfNeeded];
}


@end
