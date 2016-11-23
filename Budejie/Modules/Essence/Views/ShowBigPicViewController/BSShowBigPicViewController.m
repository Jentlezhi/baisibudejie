//
//  BSShowBigPicViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/22.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSShowBigPicViewController.h"
#import "BSEssenceListModel.h"
#import "BSProgressView.h"

@interface BSShowBigPicViewController ()<UIScrollViewDelegate>

/** 滚动视图 */
@property(weak, nonatomic) UIScrollView *picScrollView;
/** 滚动视图 */
@property(weak, nonatomic) UIImageView *picView;
/** 图片加载进度 */
@property (weak, nonatomic) BSProgressView *progressView;
/** 保存按钮 */
@property (weak, nonatomic) UIButton *saveBtn;
/** 转发按钮 */
@property (weak, nonatomic) UIButton *transBtn;

@end

@implementation BSShowBigPicViewController

- (UIScrollView *)picScrollView{
    if (!_picScrollView) {
        UIScrollView *picScrollView = [[UIScrollView alloc] init];
        picScrollView.frame = self.view.bounds;
        picScrollView.backgroundColor = [UIColor blackColor];
        picScrollView.showsHorizontalScrollIndicator = NO;
        picScrollView.delegate = self;
        picScrollView.maximumZoomScale = 1.5f;
        picScrollView.minimumZoomScale = 1.0f;
        [self.view addSubview:picScrollView];
        _picScrollView = picScrollView;
    }
    return _picScrollView;
}

+ (instancetype)showBigPicViewController{
    return [[self alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBigPicBasicConfig];
    [self initShowBigPicComponents];
}

/**
 *  基本配置
 */
- (void)showBigPicBasicConfig{
    self.navigationZone.hidden = YES;
}

/**
 *  初始化子控件
 */
- (void)initShowBigPicComponents{
    //添加图片
    UIImageView *picView = [[UIImageView alloc] init];
    picView.userInteractionEnabled = YES;
    [self.picScrollView addSubview:picView];
    _picView = picView;
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] init];
    singleTapGesture.numberOfTapsRequired = 1;
    [[singleTapGesture rac_gestureSignal] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    [picView addGestureRecognizer:singleTapGesture];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] init];
    doubleTapGesture.numberOfTapsRequired = 2;
    [[doubleTapGesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *doubleTapGesture) {
        CGPoint currentPoint = [doubleTapGesture locationInView:doubleTapGesture.view];
        CGFloat zoomWH = 60.0f;
        CGRect zoomZone = CGRectMake(currentPoint.x - zoomWH*0.5, currentPoint.y - zoomWH*0.5, zoomWH, zoomWH);
        UIScrollView *currentScrollView = (UIScrollView *)doubleTapGesture.view.superview;
        currentScrollView.zoomScale > 1 ? [currentScrollView setZoomScale:1 animated:YES]:[currentScrollView zoomToRect:zoomZone animated:YES];
        
    }];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [picView addGestureRecognizer:doubleTapGesture];
    
    //图片加载进度
    BSProgressView *progressView = [[BSProgressView alloc] init];
    progressView.circleColor = BSRGBColor(208, 208, 208);
    progressView.progressColor = BSRGBColor(226, 226, 226);
    [self.view addSubview:progressView];
    _progressView = progressView;
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BSALayoutH(150), BSALayoutH(150)));
        make.center.equalTo(self.view);
    }];
    
   //设置滚动视图的属性
    CGFloat picWidth = kScreenWidth;
    CGFloat picHeight = picWidth*self.essenceListModel.height/self.essenceListModel.width;
    if (picHeight>kScreenHeight) {
        picView.frame = CGRectMake(0, 0, picWidth, picHeight);
        self.picScrollView.contentSize = CGSizeMake(0, picHeight);
    }else{
        picView.size = CGSizeMake(picWidth, picHeight);
        picView.centerY = kScreenHeight * 0.5;
    }
    
    //显示已保存的进度（防止网速忙循环利用其他cell的进度）
    self.progressView.progressValue = self.essenceListModel.picProgressValue;
    //再显示正在下载的进度
    [picView sd_setImageWithURL:[NSURL URLWithString:self.essenceListModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.essenceListModel.picProgressValue = 1.0*receivedSize/expectedSize;
        self.progressView.progressValue = self.essenceListModel.picProgressValue;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.saveBtn.enabled = YES;
        self.saveBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.transBtn.enabled = YES;
        self.transBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.progressView.hidden = YES;
    }];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(BSALayoutH(30));
        make.top.equalTo(self.view).offset(BSALayoutV(40));
        make.size.equalTo(CGSizeMake(BSALayoutH(70), BSALayoutH(70)));
    }];
    
    //保存按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.picView.image) {
        saveBtn.enabled = YES;
        saveBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }else{
        saveBtn.enabled = NO;
        saveBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    saveBtn.layer.borderWidth = 0.5f;
    saveBtn.layer.cornerRadius = 2;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    UIColor *saveBtnBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    saveBtn.backgroundColor = saveBtnBgColor;
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIImageWriteToSavedPhotosAlbum(self.picView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }];
    [self.view addSubview:saveBtn];
    _saveBtn = saveBtn;
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(BSALayoutH(30));
        make.bottom.equalTo(self.view).offset(-BSALayoutH(30));
        make.size.equalTo(CGSizeMake(BSALayoutH(100), BSALayoutH(50)));
    }];
    
    //转发
    UIButton *transBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.picView.image) {
        transBtn.enabled = YES;
        transBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }else{
        transBtn.enabled = NO;
        transBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    transBtn.layer.borderWidth = 0.5f;
    transBtn.layer.cornerRadius = 3;
    transBtn.layer.masksToBounds = YES;
    [transBtn setTitle:@"转发" forState:UIControlStateNormal];
    UIColor *transBtnBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    transBtn.backgroundColor = transBtnBgColor;
    transBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [transBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [transBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [[transBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [self.view addSubview:transBtn];
    _transBtn = transBtn;
    [transBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view).offset(-BSALayoutH(30));
        make.size.equalTo(CGSizeMake(BSALayoutH(100), BSALayoutH(50)));
    }];
    
}
/**
 * 图片保存结果的回调
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        [MBProgressHUD showSuccessWithMessage:@"保存成功！"];
    }else{
        [MBProgressHUD showErrorWithMessage:@"保存失败！"];
    }
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    UIImageView *imamgeView = scrollView.subviews.firstObject;
    imamgeView.center = [self centerOfScrollViewContent:scrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  scrollView.subviews.firstObject;
}

/**
 * 缩放调整
 */
- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView{
    
    CGFloat offsetX = (scrollView.width > scrollView.contentSize.width)?
    (scrollView.width - scrollView.contentSize.width)*0.5 : 0.0;
    CGFloat offsetY = (scrollView.height > scrollView.contentSize.height)?
    (scrollView.height - scrollView.contentSize.height)*0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height*0.5 + offsetY);
    return actualCenter;
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
