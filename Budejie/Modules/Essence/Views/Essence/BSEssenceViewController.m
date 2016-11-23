//
//  BSEssenceViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSTagViewController.h"
#import "BSEssenceBaseViewController.h"

#define kTitleScrollViewHeight BSALayoutH(70)

@interface BSEssenceViewController()<UIScrollViewDelegate>
/** 标题视图 */
@property(strong, nonatomic) UIScrollView *titleScrollView;
/** 内容视图 */
@property(strong, nonatomic) UIScrollView *contentScrollView;
/** 标题数据 */
@property(copy, nonatomic) NSArray *titleArray;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 加载类型 */
@property(assign,nonatomic)BSTopicType type;

@end


@implementation BSEssenceViewController
/**
 * 标题视图
 */
- (UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
    }
    return _titleScrollView;
}
/**
 * 内容视图
 */
- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.backgroundColor = [UIColor whiteColor];
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
        _contentScrollView.backgroundColor = BSGlobalColor;
    }
    return _contentScrollView;
}


- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    }
    return _titleArray;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self essenceBasicConfig];
    [self initEssenceChildViewControllers];
    [self initEssenceComponents];

}
/**
 *  基本配置
 */
- (void)essenceBasicConfig{

}

/**
 *  初始化子控件
 */
- (void)initEssenceComponents{
    //左按钮
    UIButton *leftButton = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"]];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController pushViewController:[[BSTagViewController alloc] init]animated:YES];
    }];
    //标题按钮
    UIImageView *titleButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self createNavBarWithLeftButton:leftButton titleView:titleButton andRightButton:nil];
    
    //顶部标题
    CGFloat titleScrollViewX = 0;
    CGFloat titleScrollViewY = BSViewOriginY;
    CGFloat titleScrollViewW = kScreenWidth;
    CGFloat titleScrollViewH = kTitleScrollViewHeight;
    self.titleScrollView.frame = CGRectMake(titleScrollViewX, titleScrollViewY, titleScrollViewW, titleScrollViewH);
    [self.view insertSubview:self.titleScrollView belowSubview:self.navigationZone];
    
    //底部分割线
    UILabel *bottomLine = [[UILabel alloc] init];
    bottomLine.backgroundColor = BSGlobalColor;
    [self.navigationZone addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.titleScrollView);
        make.height.equalTo(BSDividerHeight);
    }];
    
    //标题视图
    CGFloat titleBtnX = 0;
    CGFloat titleBtnY = 0;
    CGFloat titleBtnW = kScreenWidth/5;
    CGFloat titleBtnH = kTitleScrollViewHeight-2;
    NSInteger tittleNo = self.titleArray.count;
    self.titleScrollView.contentSize = CGSizeMake(tittleNo*titleBtnW, 0);

    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = kTitleScrollViewHeight - indicatorView.height;
    [self.titleScrollView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    for (int index = 0; index < tittleNo; index++) {
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBtn.userInteractionEnabled = YES;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        titleBtn.tag = 1000+index;
        [titleBtn setTitle:self.titleArray[index] forState:UIControlStateNormal];
        titleBtnX = titleBtnW*index;
        titleBtn.frame = CGRectMake(titleBtnX , titleBtnY, titleBtnW, titleBtnH);
        //默认选中第一个按钮
        if (index==0) {
            titleBtn.enabled = NO;
            self.selectedButton = titleBtn;
            // 让按钮内部的label根据文字内容来计算尺寸
            [titleBtn.titleLabel sizeToFit];
            self.indicatorView.width = titleBtn.titleLabel.width;
            self.indicatorView.centerX = titleBtn.centerX;
            
        }
        [[titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *titleBtn) {
            [self titleScrollViewClick:titleBtn];
            
        }];
        [self.titleScrollView addSubview:titleBtn];
    }
    
    //内容视图
    [self.view insertSubview:self.contentScrollView belowSubview:self.titleScrollView];
    self.contentScrollView.contentSize = CGSizeMake(tittleNo*kScreenWidth, 0);
    self.contentScrollView.frame = self.view.bounds;
    //添加第一个视图
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)initEssenceChildViewControllers{
    //全部
    BSEssenceBaseViewController *allVC = [[BSEssenceBaseViewController alloc] init];
    allVC.type = BSTopicTypeAll;
    [self addChildViewController:allVC];
    //视频
    BSEssenceBaseViewController *videoVC = [[BSEssenceBaseViewController alloc] init];
    videoVC.type = BSTopicTypeVideo;
    [self addChildViewController:videoVC];
    //声音
    BSEssenceBaseViewController *voiceVC = [[BSEssenceBaseViewController alloc] init];
    voiceVC.type = BSTopicTypeVoice;
    [self addChildViewController:voiceVC];
    //图片
    BSEssenceBaseViewController *pictureVC = [[BSEssenceBaseViewController alloc] init];
    pictureVC.type = BSTopicTypePicture;
    [self addChildViewController:pictureVC];
    //段子
    BSEssenceBaseViewController *jokeVC = [[BSEssenceBaseViewController alloc] init];
    jokeVC.type = BSTopicTypeJoke;
    [self addChildViewController:jokeVC];
}
/**
 * 标题按钮的点击
 */
- (void)titleScrollViewClick:(UIButton *)titleBtn{
    self.selectedButton.enabled = YES;
    titleBtn.enabled = NO;
    self.selectedButton = titleBtn;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = titleBtn.titleLabel.width;
        self.indicatorView.centerX = titleBtn.centerX;
    }];
    //顶部标题居中显示
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    NSInteger index = titleBtn.tag - 1000;
    if (index!=0) {
        titleOffset.x = titleBtn.center.x - kScreenWidth*0.5;
    }
    //超出处理
    if (titleOffset.x<0)titleOffset.x = 0;
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width-kScreenWidth;
    if (titleOffset.x>maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    //添加子控制器
    [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
}

#pragma mark -<UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    UIViewController *childVC = self.childViewControllers[index];
    childVC.view.x = scrollView.contentOffset.x;
    childVC.view.y = 0;
    childVC.view.height = scrollView.height;
    [self.contentScrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    NSInteger index = self.contentScrollView.contentOffset.x / kScreenWidth;
    [self titleScrollViewClick:self.titleScrollView.subviews[index+1]];
}


@end
