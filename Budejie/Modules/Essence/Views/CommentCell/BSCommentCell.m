//
//  BSCommentCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSCommentCell.h"
#import "BSCommentModel.h"
#import "BSUserModel.h"

@interface BSCommentCell()

/** 用户头像 */
@property(weak, nonatomic) UIImageView *headerImgv;
/** 用户性别 */
@property(weak, nonatomic) UIImageView *genderImgv;
/** 所推荐的用户昵称 */
@property(weak, nonatomic) UILabel *nicknameLabel;
/** 音频按钮 */
@property(weak, nonatomic) UIButton *voicePlayBtn;
/** 点赞数目 */
@property(weak, nonatomic) UILabel *praiseNumLabel;
/** 内容 */
@property(weak, nonatomic) UILabel *contentLabel;
/** 点赞按钮 */
@property(weak, nonatomic) UIButton *praiseBtn;
/** 鼓掌动画 */
@property(strong, nonatomic) NSArray *clapImages;


@end

@implementation BSCommentCell

- (NSArray *)clapImages{
    if (!_clapImages) {
        _clapImages = [NSArray array];
        NSMutableArray *tempMArray = [NSMutableArray array];
        for (NSInteger index = 0; index < 3; index++) {
            NSString *imageName = [NSString stringWithFormat:@"post_thanks_%ld.jpg",index+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [tempMArray addObject:image];
        }
        _clapImages = tempMArray;
    }
    return _clapImages;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commentCellBasicConfig];
        [self initCommentCellComponents];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)commentCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    //cell选中时颜色设置
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = BSGlobalColor;
}

/**
 *  初始化子控件
 */
- (void)initCommentCellComponents{
    //用户头像
    UIImageView *headerImgv = [[UIImageView alloc] init];
//    headerImgv.layer.cornerRadius = BSCommentHeaderWH*0.5;
//    headerImgv.layer.masksToBounds = YES;
    [self.contentView addSubview:headerImgv];
    _headerImgv = headerImgv;
    [headerImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BSCommentHeaderWH, BSCommentHeaderWH));
        make.left.top.equalTo(self.contentView).offset(BSCommentMarign);
    }];

    //性别标识
    UIImageView *genderImgv = [[UIImageView alloc] init];
    [self.contentView addSubview:genderImgv];
    _genderImgv = genderImgv;
    [genderImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImgv);
        make.left.equalTo(headerImgv.mas_right).offset(BSEssenceCellMargin);
        make.size.equalTo(CGSizeMake(BSALayoutV(30), BSALayoutV(30)));
    }];
    //点赞按钮
    UIButton *praiseBtn = [UIButton buttonWithNormalImage:[UIImage imageNamed:@"commentLikeButton"] highlightImage:[UIImage imageNamed:@"commentLikeButtonClick"]];
    [[praiseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.headerImgv animationWithImages:self.clapImages duration:1.0f repeatCount:1];
    }];
    [self.contentView addSubview:praiseBtn];
    _praiseBtn = praiseBtn;
    [praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-BSEssenceCellMargin);
        make.centerY.equalTo(genderImgv);
        make.size.equalTo(CGSizeMake(BSALayoutV(60), BSALayoutV(60)));
    }];
    
    //点赞数
    UILabel *praiseNumLabel = [[UILabel alloc] init];
    praiseNumLabel.textColor = BSRGBColor(34, 34, 34);
    praiseNumLabel.font = [UIFont systemFontOfSize:12];
    praiseNumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:praiseNumLabel];
    _praiseNumLabel = praiseNumLabel;
    [praiseNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(praiseBtn.mas_left);
        make.centerY.equalTo(praiseBtn).offset(BSALayoutV(4));
        make.width.equalTo(BSALayoutH(26*8));
        make.height.equalTo(praiseNumLabel.font.pointSize);
    }];
    
    //用户昵称
    UILabel *nicknameLabel = [[UILabel alloc] init];
    nicknameLabel.textColor = BSRGBColor(50, 95, 153);
    nicknameLabel.font = [UIFont systemFontOfSize:13];
    nicknameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nicknameLabel];
    _nicknameLabel = nicknameLabel;
    [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImgv);
        make.left.equalTo(genderImgv.mas_right).offset(BSEssenceCellMargin);
        make.right.equalTo(praiseBtn.mas_left);
        make.height.equalTo(BSALayoutV(28));
    }];

    //内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = BSRGBColor(117, 117, 117);
    contentLabel.font = BSCommnetContentFont;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_praiseBtn.mas_bottom).offset(BSEssenceCellMargin);
        make.left.equalTo(_headerImgv.mas_right).offset(BSEssenceCellMargin);
        make.right.equalTo(self.contentView).offset(-BSEssenceCellMargin);
        make.bottom.equalTo(self.contentView).offset(-BSCommentMarign);
        
    }];
    
    //音频播放按钮
    UIButton *voicePlayBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"play-voice-bg"] highlightImage:[UIImage imageNamed:@"play-voice-bg-select"]];
    [voicePlayBtn setImage:[UIImage imageNamed:@"play-voice-stop"] forState:UIControlStateNormal];
    [voicePlayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    voicePlayBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    voicePlayBtn.titleEdgeInsets = UIEdgeInsetsMake(0, BSALayoutH(5), 0, 0);
    [[voicePlayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    }];
    [self.contentView addSubview:voicePlayBtn];
    _voicePlayBtn = voicePlayBtn;
    
    //分割线
    UILabel *dividerLabel = [[UILabel alloc] init];
    dividerLabel.backgroundColor = BSGlobalColor;
    [self.contentView addSubview:dividerLabel];
    [dividerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(BSDividerHeight);
    }];


}

+ (instancetype)commentCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSCommentCellID";
    BSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setCommentModel:(BSCommentModel *)commentModel{
    _commentModel = commentModel;
    [_headerImgv sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image] placeholderImage:BSUserHeaderPlaceholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _headerImgv.image = [image circleImageWithBorderWidth:BSALayoutH(2.f) borderColor:BSGlobalColor];
    }];
    _genderImgv.image = [commentModel.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = commentModel.content;
    self.nicknameLabel.text = commentModel.user.username;
    self.praiseNumLabel.text = [NSString stringWithFormat:@"%zd", commentModel.like_count];

    if (commentModel.voiceuri.length) {
        self.voicePlayBtn.hidden = NO;
        [self.voicePlayBtn setTitle:[NSString stringWithFormat:@"%zd''", commentModel.voicetime] forState:UIControlStateNormal];
        [_voicePlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(BSALayoutH(124));
            make.top.equalTo(_praiseBtn.mas_bottom).offset(BSEssenceCellMargin);
            make.left.equalTo(_headerImgv.mas_right).offset(BSEssenceCellMargin);
            make.bottom.equalTo(self.contentView).offset(-BSCommentMarign);
        }];
    } else {
        self.voicePlayBtn.hidden = YES;

    }
}

#pragma mark - MenuController setting

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}
/**
 * 跳转cell的frame
 */
- (void)setFrame:(CGRect)frame{
    frame.origin.x=BSEssenceCellMargin;
    frame.size.width-=2*BSEssenceCellMargin;
    [super setFrame:frame];
}

@end
