//
//  BSPublishView.m
//  Budejie
//
//  Created by Jentle on 2016/11/23.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSPublishView.h"
#import "BSVerticalButton.h"
#import <POP.h>

#define BSSpringBounciness  5.0f
#define BSSpringSpeed  20.0f
#define BSAnimationDelay 0.1f

NSInteger const BSTitleBtnBeginTag = 1000;

@interface BSPublishView()
/** 标题 */
@property(strong, nonatomic) NSArray *titles;
/** 标题图片 */
@property(strong, nonatomic) NSArray *titleImages;
/** window视图 */
@property(strong, nonatomic) UIWindow *window;

@end

BSPublishView *publishView_;

@implementation BSPublishView
{
   BOOL _userInteractionEnabled;
}
- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] init];
        _window.backgroundColor = [UIColor clearColor];
        _window.windowLevel = UIWindowLevelStatusBar;
        UIImageView *windowBg = [[UIImageView alloc] init];
        windowBg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self cancelWithCompletionBlock:nil];
        }];
        [windowBg addGestureRecognizer:tap];
        windowBg.frame = _window.bounds;
        windowBg.image = [UIImage imageNamed:@"shareBottomBackground"];
        [_window addSubview:windowBg];
    }
    return _window;
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    }
    return _titles;
}

- (NSArray *)titleImages{
    if (!_titleImages) {
        _titleImages = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];;
    }
    return _titleImages;
}

+ (void)show{
    if (!publishView_) {
        publishView_ = [[self alloc] init];
        publishView_.window.hidden = NO;
    }
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self publicBasicConfig];
        [self initPublishComponent];
    }
    return self;
}
/**
 * 基本配置
 */
- (void)publicBasicConfig{
    self.userInteractionEnabled = NO;
}

/**
 * 初始化子控件
 */
- (void)initPublishComponent{
    //标语
    UIImageView *slogan = [[UIImageView alloc] init];
    slogan.image = [UIImage imageNamed:@"app_slogan"];
    [self.window addSubview:slogan];
    
    //添加标题按钮
    CGFloat btnX = 0.0f;
    CGFloat btnY = 0.0f;
    CGFloat btnW = BSALayoutH(144);
    CGFloat btnH = BSALayoutH(144+32+15);
    CGFloat btnEndY = kScreenHeight*0.5 - btnH;
    
    NSInteger btnNum = self.titles.count;
    NSInteger btnRow = 2;
    NSInteger btnClo = 3;
    
    CGFloat marginH = BSALayoutH(30);
    CGFloat itemMarginH = (kScreenWidth - btnClo*btnW - 2*marginH)/btnRow;
    CGFloat itemMarginV = BSALayoutH(30);
    
    for (int index = 0; index<btnNum; index++) {
        BSVerticalButton *btn = [[BSVerticalButton alloc] init];
        btn.tag = BSTitleBtnBeginTag + index;
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:[UIImage imageNamed:self.titleImages[index]] forState:UIControlStateNormal];
        [btn setTitleColor:BSRGBColor(66, 66, 66) forState:UIControlStateNormal];
        btn.contentMargin = BSALayoutH(20);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:self.titles[index] forState:UIControlStateNormal];
        btnX = index%btnClo*(btnW + itemMarginH) + marginH;
        btnY = index/btnClo*(btnH+ itemMarginV) + btnEndY;
        CGFloat btnBeginY = btnY - kScreenHeight;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(BSVerticalButton *btn) {
            NSInteger index = btn.tag - BSTitleBtnBeginTag;
            [self cancelWithCompletionBlock:^{
               BSLog(@"点击了[%@]按钮",self.titles[index]);
            }];
        }];
        [self.window addSubview:btn];
        
        //按钮动画
        POPSpringAnimation *btnAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        btnAnim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnBeginY, btnW, btnH)];
        btnAnim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        btnAnim.springBounciness = BSSpringBounciness;
        btnAnim.springSpeed = BSSpringSpeed;
        btnAnim.beginTime = CACurrentMediaTime() + BSAnimationDelay * (btnNum-index);
        [btn pop_addAnimation:btnAnim forKey:nil];
    }
    //标语frame
    CGFloat sloganW = BSALayoutH(404);
    CGFloat sloganH = BSALayoutH(40);
    CGFloat sloganX = (kScreenWidth - sloganW)*0.5;
    CGFloat sloganY = BSALayoutV(260);
    CGFloat sloganBeginY = sloganY - kScreenHeight;
    //标语动画
    POPSpringAnimation *sloganAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    sloganAnim.fromValue = [NSValue valueWithCGRect:CGRectMake(sloganX, sloganBeginY, sloganW, sloganH)];
    sloganAnim.toValue = [NSValue valueWithCGRect:CGRectMake(sloganX, sloganY, sloganW, sloganH)];
    sloganAnim.springBounciness = BSSpringBounciness;
    sloganAnim.springSpeed = BSSpringSpeed;
    sloganAnim.beginTime = CACurrentMediaTime() + BSAnimationDelay * btnNum;
    [sloganAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    [slogan pop_addAnimation:sloganAnim forKey:nil];
    [self.window insertSubview:slogan atIndex:1];
    
    
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6]] forState:UIControlStateNormal];
    cancelBtn.adjustsImageWhenHighlighted = NO;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.window addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.window);
        make.centerX.equalTo(self.window);
        make.left.right.equalTo(self.window);
        make.height.equalTo(BSALayoutV(80));
    }];
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self cancelWithCompletionBlock:nil];
    }];
    
}

/**
 * 消失动画
 */
- (void)cancelWithCompletionBlock:(void(^)())completionBlock{
    //执行消失动画
    NSInteger beginIndex = 1;
    NSInteger itemNum = self.window.subviews.count;
    for (NSInteger index = beginIndex; index<itemNum; index++) {
        UIView *subview = self.window.subviews[itemNum-index];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + kScreenHeight;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (index - beginIndex) * BSAnimationDelay;
        anim.duration = 0.4;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [subview pop_addAnimation:anim forKey:nil];
        
        if ( index == itemNum - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                _window = nil;
                [publishView_ removeFromSuperview];
                publishView_ = nil;
                !completionBlock?:completionBlock();
            }];
        }
        
    }
    
}


@end
