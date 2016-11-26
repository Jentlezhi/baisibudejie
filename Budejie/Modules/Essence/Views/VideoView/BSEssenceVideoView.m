//
//  BSEssenceVideoView.m
//  Budejie
//
//  Created by Jentle on 2016/11/23.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceVideoView.h"
#import "BSEssenceListModel.h"

#define BSVideoLabelFont [UIFont systemFontOfSize:14]

@interface BSEssenceVideoView()

/** 播放总量 */
@property (weak, nonatomic) UILabel *playCountLabel;
/** 视频时长 */
@property (weak, nonatomic) UILabel *videoLaststimeLabel;
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 播放按钮 */
@property (weak, nonatomic) UIButton *playVideoButton;

@end

@implementation BSEssenceVideoView
- (RACSubject *)videoPlaySignal{
    if (!_videoPlaySignal) {
        _videoPlaySignal = [RACSubject subject];
    }
    return _videoPlaySignal;
}


- (instancetype)init{
    if (self = [super init]) {
        [self essenceVideoBasicConfig];
        [self initEssenceVideoComponents];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self essenceVideoBasicConfig];
}
/**
 *  基本配置
 */
- (void)essenceVideoBasicConfig{
    //设置背景色
    self.backgroundColor = BSGlobalColor;
}

/**
 *  初始化子控件
 */
- (void)initEssenceVideoComponents{
    //占位图片
    UIImageView *placeHolderImgv = [[UIImageView alloc] init];
    placeHolderImgv.image = [UIImage imageNamed:@"imageBackground"];
    [self addSubview:placeHolderImgv];
    [placeHolderImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BSALayoutH(300), BSALayoutH(60)));
        make.top.equalTo(self).offset(BSEssenceCellMargin);
        make.centerX.equalTo(self);
    }];
    
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    _imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    //总播放量
    UILabel *playCountLabel = [[UILabel alloc] init];
    playCountLabel.textColor = [UIColor whiteColor];
    playCountLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    playCountLabel.font = BSVideoLabelFont;
    playCountLabel.layer.cornerRadius = 1.5f;
    playCountLabel.layer.masksToBounds = YES;
    playCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:playCountLabel];
    _playCountLabel = playCountLabel;
    
    //持续时长
    UILabel *videoLaststimeLabel = [[UILabel alloc] init];
    videoLaststimeLabel.textColor = [UIColor whiteColor];
    videoLaststimeLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    videoLaststimeLabel.font = BSVideoLabelFont;
    videoLaststimeLabel.layer.cornerRadius = 1.5f;
    videoLaststimeLabel.layer.masksToBounds = YES;
    videoLaststimeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:videoLaststimeLabel];
    _videoLaststimeLabel = videoLaststimeLabel;
    
    //播放按钮
    UIButton *playVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playVideoButton.adjustsImageWhenHighlighted = NO;
    [playVideoButton setBackgroundImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    [[playVideoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.videoPlaySignal sendNext:self.essenceListModel];
    }];
    [self addSubview:playVideoButton];
    _playVideoButton = playVideoButton;
    [playVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(CGSizeMake(BSALayoutH(126), BSALayoutH(126)));
    }];
    
}

- (void)setEssenceListModel:(BSEssenceListModel *)essenceListModel{
    _essenceListModel = essenceListModel;
    
    //图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:essenceListModel.large_image]];
    
    //总播放量
    NSString *playCount = [NSString stringWithFormat:@"%zd次播放",essenceListModel.playcount];
    self.playCountLabel.text = playCount;
    CGFloat playCountLabelW = [playCount sizeWithFont:BSVideoLabelFont maxSize:CGSizeMake(CGFLOAT_MAX, self.playCountLabel.font.pointSize)].width+10;
    [self.playCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.size.equalTo(CGSizeMake(playCountLabelW, BSALayoutH(40)));
    }];
    //持续时长
    NSInteger minute = essenceListModel.videotime / 60;
    NSInteger second = essenceListModel.videotime % 60;
    NSString *voiceLaststime = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.videoLaststimeLabel.text = voiceLaststime;
    CGFloat voiceLaststimeW = [voiceLaststime sizeWithFont:BSVideoLabelFont maxSize:CGSizeMake(CGFLOAT_MAX, self.videoLaststimeLabel.font.pointSize)].width+10;
    [self.videoLaststimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.size.equalTo(CGSizeMake(voiceLaststimeW, BSALayoutH(40)));
    }];
}




@end
