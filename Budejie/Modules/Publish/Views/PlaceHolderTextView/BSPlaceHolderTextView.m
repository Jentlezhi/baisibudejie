//
//  BSPlaceHolderTextView.m
//  Budejie
//
//  Created by Jentle on 2016/11/30.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSPlaceHolderTextView.h"

@interface BSPlaceHolderTextView()

@property(weak, nonatomic) UILabel *placeholderLabel;

@end

@implementation BSPlaceHolderTextView

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.font = self.font;
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self placeholderBasicConfig];
    }
    return self;
}

- (void)placeholderBasicConfig{
    self.tintColor = BSRedColor;
    self.placeholderColor = BSGrayColor(160);
    self.font = [UIFont systemFontOfSize:15.0f];
    self.alwaysBounceVertical = YES;
    [BSNotificationCenter addObserver:self selector:@selector(textDidChage) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    ;
    CGFloat margin = BSALayoutH(15);
    self.placeholderLabel.x = margin;
    self.placeholderLabel.y = margin;
    
    CGFloat marign = BSALayoutH(10);
//    CGSize holdeLabelMaxSize = CGSizeMake(self.width-2*marign, CGFLOAT_MAX);
//    self.placeholderLabel.size = [self.placeholder sizeWithFont:self.font maxSize:holdeLabelMaxSize];
    CGFloat holderW = self.width-2*marign;
    self.placeholderLabel.width = holderW;
    [self.placeholderLabel sizeToFit];
}


- (void)textDidChage{
    if ([self hasText]) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
}

- (void)dealloc{
    [BSNotificationCenter removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder{
    ;
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self layoutIfNeeded];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    ;
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font{
    ;
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChage];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChage];
}


@end
