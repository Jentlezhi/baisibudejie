//
//  BSMineFooterView.m
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSMineFooterView.h"
#import "BSMineItemModel.h"
#import "BSSquareButton.h"
#import "BSWebViewController.h"

@implementation BSMineFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self footerViewBasicConfig];
        [self initFooterViewComponents];
    }
    return self;
}

- (void)footerViewBasicConfig{
    
}
- (void)initFooterViewComponents{
    

    
}

- (void)setMineItems:(NSArray *)mineItems{
    _mineItems = mineItems;
    //创建按钮
    NSUInteger itemNum = mineItems.count?mineItems.count:12;
    
    CGFloat margin = BSEssenceCellMargin;
    NSUInteger maxCols = 4;
    CGFloat itemBtnW = (kScreenWidth - 2*margin)/maxCols;
    CGFloat itemBtnH = itemBtnW;
    CGFloat itemBtnX = 0;
    CGFloat itemBtnY = 0;
    
    for (NSUInteger index = 0; index<itemNum; index++) {
        BSSquareButton *itemBtn = [BSSquareButton buttonWithType:UIButtonTypeCustom];
        BSMineItemModel *itemModle = mineItems.count?mineItems[index]:nil;
        itemBtn.mineItemModel = itemModle;
        itemBtnX = index%maxCols*itemBtnW + margin;
        itemBtnY = index/maxCols*itemBtnH;
        itemBtn.frame = CGRectMake(itemBtnX, itemBtnY, itemBtnW, itemBtnH);
        //点击事件
        [[itemBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (![itemModle.url hasPrefix:@"http"]) return;
            BSWebViewController *webVC = [[BSWebViewController alloc] init];
            webVC.navTitle = itemModle.name;
            webVC.url = itemModle.url;
            UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
            [nav pushViewController:webVC animated:YES];
        }];
        [self addSubview:itemBtn];
    }
    
    NSUInteger rows = (itemNum + maxCols - 1) / maxCols;
    self.height = rows*itemBtnH;
    [self setNeedsDisplay];
}
@end
