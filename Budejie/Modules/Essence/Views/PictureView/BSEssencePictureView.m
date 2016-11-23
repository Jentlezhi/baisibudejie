//
//  BSEssencePictureView.m
//  Budejie
//
//  Created by Jentle on 2016/11/21.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssencePictureView.h"
#import "BSEssenceListModel.h"
#import "BSProgressView.h"

@interface BSEssencePictureView()
/** gif标识 */
@property (weak, nonatomic) UIImageView *gifView;
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 查看大图按钮 */
@property (weak, nonatomic) UIButton *seeBigButton;
/** 图片加载进度 */
@property (weak, nonatomic) BSProgressView *progressView;


@end

@implementation BSEssencePictureView

- (RACSubject *)seeBigPicSignal{
    if (!_seeBigPicSignal) {
        _seeBigPicSignal = [RACSubject subject];
    }
    return _seeBigPicSignal;
}

- (instancetype)init{
    if (self = [super init]) {
        [self essencePicBasicConfig];
        [self initEssencePicComponents];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self essencePicBasicConfig];
}
/**
 *  基本配置
 */
- (void)essencePicBasicConfig{
    //设置背景色
    self.backgroundColor = BSGlobalColor;
}

/**
 *  初始化子控件
 */
- (void)initEssencePicComponents{
    //占位图片
    UIImageView *placeHolderImgv = [[UIImageView alloc] init];
    placeHolderImgv.image = [UIImage imageNamed:@"imageBackground"];
    [self addSubview:placeHolderImgv];
    [placeHolderImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BSALayoutH(300), BSALayoutH(60)));
        make.top.equalTo(self).offset(BSEssenceCellMargin);
        make.centerX.equalTo(self);
    }];
    
    //图片加载进度
    BSProgressView *progressView = [[BSProgressView alloc] init];
    progressView.circleColor = BSRGBColor(208, 208, 208);
    progressView.progressColor = BSRGBColor(226, 226, 226);
    [self addSubview:progressView];
    _progressView = progressView;
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BSALayoutH(150), BSALayoutH(150)));
        make.center.equalTo(self);
    }];
    
    
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [self.seeBigPicSignal sendNext:self.essenceListModel];
    }];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
    _imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    //gif标识
    UIImageView *gifView = [[UIImageView alloc] init];
    gifView.image = [UIImage imageNamed:@"common-gif"];
    [self addSubview:gifView];
    _gifView = gifView;
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.size.equalTo(CGSizeMake(BSALayoutH(62), BSALayoutH(62)));
    }];
    //查看大图按钮
    UIButton *seeBigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    seeBigButton.userInteractionEnabled = NO;
    seeBigButton.titleLabel.font = [UIFont systemFontOfSize:18];
    seeBigButton.adjustsImageWhenDisabled = NO;
    seeBigButton.titleEdgeInsets = UIEdgeInsetsMake(0, BSALayoutH(10), 0, 0);
    [seeBigButton setImage:[UIImage imageNamed:@"see-big-picture"] forState:UIControlStateNormal];
    [seeBigButton setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background"] forState:UIControlStateNormal];
    [seeBigButton setTitle:@"点击查看全图" forState:UIControlStateNormal];
    [self addSubview:seeBigButton];
    _seeBigButton = seeBigButton;
    [seeBigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(BSALayoutH(86));
    }];
    
}

- (void)setEssenceListModel:(BSEssenceListModel *)essenceListModel{
    _essenceListModel = essenceListModel;
    self.gifView.hidden = !essenceListModel.isGifPic;
    //设置图片
      //显示已保存的进度（防止网速忙循环利用其他cell的进度）
    self.progressView.progressValue = essenceListModel.picProgressValue;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:essenceListModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        essenceListModel.picProgressValue = 1.0*receivedSize/expectedSize;
        self.progressView.progressValue = essenceListModel.picProgressValue;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        if (essenceListModel.isBigPic) {
            UIGraphicsBeginImageContextWithOptions(essenceListModel.pictureF.size, YES, 0.0f);
            CGFloat width = essenceListModel.pictureF.size.width;
            CGFloat height = width*image.size.height/image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
    }];
    //是否显示“点击查看全图” 按钮
    self.seeBigButton.hidden = !essenceListModel.isBigPic;

}



@end
