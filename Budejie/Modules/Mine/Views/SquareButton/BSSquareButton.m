//
//  BSSquareButton.m
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSSquareButton.h"
#import "BSMineItemModel.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation BSSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self squareButtonBasicConfig];
        [self squareButtonInitComponents];
    }
    return self;
}

- (void)squareButtonBasicConfig{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.adjustsImageWhenHighlighted = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:BSGlobalColor] forState:UIControlStateHighlighted];
}

- (void)squareButtonInitComponents{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setMineItemModel:(BSMineItemModel *)mineItemModel{
    _mineItemModel = mineItemModel;
    [self setTitle:mineItemModel.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:mineItemModel.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}


@end
