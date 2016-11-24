//
//  BSVoiceView.m
//  Budejie
//
//  Created by Jentle on 2016/11/23.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceVoiceView.h"
#import "BSEssenceListModel.h"

#define BSVoiceLabelFont [UIFont systemFontOfSize:14]

@interface BSEssenceVoiceView()

/** 播放总量 */
@property (weak, nonatomic) UILabel *playCountLabel;
/** 音频时长 */
@property (weak, nonatomic) UILabel *voiceLaststimeLabel;
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 播放按钮 */
@property (weak, nonatomic) UIButton *playVoiceButton;

@end

@implementation BSEssenceVoiceView

- (RACSubject *)voicePlaySignal{
    if (!_voicePlaySignal) {
        _voicePlaySignal = [RACSubject subject];
    }
    return _voicePlaySignal;
}


- (instancetype)init{
    if (self = [super init]) {
        [self essenceVoiceBasicConfig];
        [self initEssenceVoiceComponents];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self essenceVoiceBasicConfig];
}
/**
 *  基本配置
 */
- (void)essenceVoiceBasicConfig{
    //设置背景色
    self.backgroundColor = BSGlobalColor;
}

/**
 *  初始化子控件
 */
- (void)initEssenceVoiceComponents{
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
    playCountLabel.font = BSVoiceLabelFont;
    playCountLabel.layer.cornerRadius = 1.5f;
    playCountLabel.layer.masksToBounds = YES;
    playCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:playCountLabel];
    _playCountLabel = playCountLabel;
    
    //持续时长
    UILabel *voiceLaststimeLabel = [[UILabel alloc] init];
    voiceLaststimeLabel.textColor = [UIColor whiteColor];
    voiceLaststimeLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    voiceLaststimeLabel.font = BSVoiceLabelFont;
    voiceLaststimeLabel.layer.cornerRadius = 1.5f;
    voiceLaststimeLabel.layer.masksToBounds = YES;
    voiceLaststimeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:voiceLaststimeLabel];
    _voiceLaststimeLabel = voiceLaststimeLabel;
    
    //播放按钮
    UIButton *playVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playVoiceButton.adjustsImageWhenHighlighted = NO;
    [playVoiceButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    [playVoiceButton setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    [[playVoiceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.voicePlaySignal sendNext:self.essenceListModel];
    }];
    [self addSubview:playVoiceButton];
    _playVoiceButton = playVoiceButton;
    [playVoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
    CGFloat playCountLabelW = [NSString sizeForContent:playCount font:BSVoiceLabelFont size:CGSizeMake(CGFLOAT_MAX, self.playCountLabel.font.pointSize)].width+10;
    [self.playCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.size.equalTo(CGSizeMake(playCountLabelW, BSALayoutH(40)));
    }];
    //持续时长
    NSInteger minute = essenceListModel.voicetime / 60;
    NSInteger second = essenceListModel.voicetime % 60;
    NSString *voiceLaststime = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.voiceLaststimeLabel.text = voiceLaststime;
    CGFloat voiceLaststimeW = [NSString sizeForContent:voiceLaststime font:BSVoiceLabelFont size:CGSizeMake(CGFLOAT_MAX, self.voiceLaststimeLabel.font.pointSize)].width+10;
    [self.voiceLaststimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.size.equalTo(CGSizeMake(voiceLaststimeW, BSALayoutH(40)));
    }];
}




@end
