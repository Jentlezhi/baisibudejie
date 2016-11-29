//
//  BSWebViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSWebViewController.h"

@interface BSWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property(strong, nonatomic) UIWebView *webView;

@property(weak, nonatomic) UIButton *goBackButton;
@property(weak, nonatomic) UIButton *goForwardButton;
@property(weak, nonatomic) UIButton *refreshButton;

/** 网络加载进度条 */
@property(strong, nonatomic) NJKWebViewProgressView *progressView;
@property(strong, nonatomic) NJKWebViewProgress *progressProxy;

@end

@implementation BSWebViewController

/**
 *  添加进度条
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationBar addSubview:_progressView];
}
/**
 *  移除进度条
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}


- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.opaque = NO;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(BSViewOriginY, 0, BSTabBarHeight, 0);
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProgressBar];
    [self webBasicConfig];
    [self webInitComponents];
    [self loadRequest];
}

/**
 *  初始化进度条
 */
- (void)initProgressBar{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    self.webView.delegate = _progressProxy;
    
    CGFloat progressBarHeight = 1.5f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progressBarView.backgroundColor = [UIColor blackColor];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}


- (void)webBasicConfig{
    [self createNavBarWithBackButtonAndTitle:self.navTitle];
}

- (void)webInitComponents{
    //网页
    [self.view insertSubview:self.webView belowSubview:self.navigationZone];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    //工具条
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [self.view addSubview:toolbar];
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(BSTabBarHeight);
    }];
    
    //工具条按钮
    UIButton *goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBackButton setTitle:@"←" forState:UIControlStateNormal];
    [goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    goBackButton.frame = CGRectMake(0, 0, 18, 18);
    [[goBackButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.webView goBack];
    }];

    UIBarButtonItem *goBack = [[UIBarButtonItem alloc] initWithCustomView:goBackButton];
    _goBackButton = goBackButton;
    
    UIBarButtonItem *goBackForwardMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    goBackForwardMargin.width = BSALayoutH(60);
    
    UIButton *goForwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goForwardButton setTitle:@"→" forState:UIControlStateNormal];
    [goForwardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[goForwardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.webView goForward];
    }];
    goForwardButton.frame = CGRectMake(0, 0, 18, 18);
    UIBarButtonItem *goForward = [[UIBarButtonItem alloc] initWithCustomView:goForwardButton];
    _goForwardButton = goForwardButton;
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    refreshButton.frame = CGRectMake(0, 0, 40, 18);
    [[refreshButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.webView reload];
    }];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    _refreshButton = refreshButton;
    
    UIBarButtonItem *forwardRefreshMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    goBackForwardMargin.width = BSALayoutH(120);
    
    toolbar.items = @[goBack,goBackForwardMargin,goForward,forwardRefreshMargin,refresh];
    
    //隐藏工具栏按钮
    UIButton *hiddenToolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hiddenToolBtn setBackgroundImage:[UIImage imageNamed:@"look_"] forState:UIControlStateNormal];
    [[hiddenToolBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (toolbar.hidden) {
            toolbar.hidden = NO;
            [hiddenToolBtn setBackgroundImage:[UIImage imageNamed:@"look_"] forState:UIControlStateNormal];
            self.webView.scrollView.contentInset = UIEdgeInsetsMake(BSViewOriginY, 0, BSTabBarHeight, 0);
        }else{
            toolbar.hidden = YES;
            [hiddenToolBtn setBackgroundImage:[UIImage imageNamed:@"look_h_"] forState:UIControlStateNormal];
            self.webView.scrollView.contentInset = UIEdgeInsetsMake(BSViewOriginY, 0, 0, 0);
        }
    }];
    [self.view addSubview:hiddenToolBtn];
    [hiddenToolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-BSEssenceCellMargin);
        make.bottom.equalTo(self.view).offset(-BSTabBarHeight-BSEssenceCellMargin);
        make.size.equalTo(CGSizeMake(26, 26));
    }];
   
}

- (void)loadRequest{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goBackButton.enabled = webView.canGoBack;
    self.goForwardButton.enabled = webView.canGoForward;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_progressView removeFromSuperview];
}


#pragma mark - <NJKWebViewProgressDelegate>

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [_progressView setProgress:progress animated:YES];
}





@end
