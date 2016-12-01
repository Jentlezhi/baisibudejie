//
//  BSInputToolbar.m
//  Budejie
//
//  Created by Jentle on 2016/11/30.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSInputToolbar.h"
#import "BSAddTagViewController.h"

@implementation BSInputToolbar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self initInputViewComponents];
    }
    return self;
}

- (void)initInputViewComponents{
    //加号按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.adjustsImageWhenHighlighted = NO;
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSAddTagViewController *addTagVC = [[BSAddTagViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)BSRootViewController.presentedViewController;
        [nav pushViewController:addTagVC animated:YES];
    }];
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(BSALayoutH(70));
    }];
    
    //工具条
    UIView *bar = [[UIView alloc] init];
    bar.backgroundColor = BSGrayColor(230);
    [self addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(BSALayoutV(70));
    }];
    
    //工具条按钮
    UIButton *atBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    atBtn.adjustsImageWhenHighlighted = NO;
    [atBtn setImage:[UIImage imageNamed:@"post-@"] forState:UIControlStateNormal];
    [bar addSubview:atBtn];
    [atBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bar);
        make.width.equalTo(BSALayoutH(70));
    }];
    
    UIButton *jingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jingBtn.adjustsImageWhenHighlighted = NO;
    [jingBtn setImage:[UIImage imageNamed:@"post-#"] forState:UIControlStateNormal];
    [bar addSubview:jingBtn];
    [jingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(atBtn.mas_right);
        make.top.bottom.equalTo(bar);
        make.width.equalTo(BSALayoutH(70));
    }];
}

@end
