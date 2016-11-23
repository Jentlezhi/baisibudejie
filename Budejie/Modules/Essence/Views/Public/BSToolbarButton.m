//
//  BSToolbarButton.m
//  Budejie
//
//  Created by Jentle on 2016/11/18.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSToolbarButton.h"

@implementation BSToolbarButton

- (void)setup{
    [self setTitleColor:BSRGBColor(144, 144, 144) forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
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
    // 调整文字
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame)+BSALayoutH(6);
    self.titleLabel.centerY = self.centerY+BSALayoutV(1);
}


@end
