//
//  BSTitlteLeftButton.m
//  Budejie
//
//  Created by Jentle on 2016/12/1.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTitlteLeftButton.h"

@implementation BSTitlteLeftButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, BSMarigin/3);
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //调整label
    self.titleLabel.x = BSMarigin/3;
    self.titleLabel.y = (self.height - self.titleLabel.height)*0.5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + BSMarigin/3;
    self.imageView.width = self.titleLabel.font.pointSize;
    self.imageView.height = self.imageView.width;
    self.imageView.y = (self.height - self.imageView.height)*0.5;
    
}

@end
