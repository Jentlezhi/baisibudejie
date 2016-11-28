//
//  BSTopComment.m
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceTopCommentView.h"
#import "BSCommentModel.h"
#import "BSUserModel.h"
#import "BSEssenceListModel.h"

@interface BSEssenceTopCommentView()
/** "最新评论" */
@property (weak, nonatomic) UILabel *topCmtLabel;
/** 最热评论内容 */
@property (weak, nonatomic) UILabel *topCmtContentLabel;
/** 音频按钮 */
@property(weak, nonatomic) UIButton *voicePlayBtn;

@end

@implementation BSEssenceTopCommentView

- (instancetype)init{
    if (self = [super init]) {
        [self essenceTopCmtBasicConfig];
        [self initEssenceTopCmtComponents];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self essenceTopCmtBasicConfig];
}
/**
 *  基本配置
 */
- (void)essenceTopCmtBasicConfig{
    //设置背景色
    self.backgroundColor = BSGrayColor(239);
}

/**
 *  初始化子控件
 */
- (void)initEssenceTopCmtComponents{
    
    //"最热评论" 文字
    UILabel *topCmtLabel = [[UILabel alloc] init];
    topCmtLabel.layer.cornerRadius = 1.5f;
    topCmtLabel.layer.masksToBounds = YES;
    topCmtLabel.font = [UIFont systemFontOfSize:14.0f];
    topCmtLabel.textAlignment = NSTextAlignmentCenter;
    topCmtLabel.text = @"最热评论";
    topCmtLabel.textColor = [UIColor whiteColor];
    topCmtLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addSubview:topCmtLabel];
    _topCmtLabel = topCmtLabel;

    //最热评论内容
    UILabel *topCmtContentLabel = [[UILabel alloc] init];
    topCmtContentLabel.textColor = BSGrayColor(38.0f);
    topCmtContentLabel.numberOfLines = 0;
    topCmtContentLabel.font = [UIFont systemFontOfSize:13.0f];
    topCmtContentLabel.textAlignment = NSTextAlignmentLeft;
    [topCmtContentLabel sizeToFit];
    [self addSubview:topCmtContentLabel];
    _topCmtContentLabel = topCmtContentLabel;
    
    //音频播放按钮
    UIButton *voicePlayBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"play-voice-bg"] highlightImage:[UIImage imageNamed:@"play-voice-bg-select"]];
    [voicePlayBtn setImage:[UIImage imageNamed:@"play-voice-stop"] forState:UIControlStateNormal];
    [[voicePlayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    }];
    [voicePlayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    voicePlayBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    voicePlayBtn.titleEdgeInsets = UIEdgeInsetsMake(0, BSALayoutH(5), 0, 0);
    [self addSubview:voicePlayBtn];
    _voicePlayBtn = voicePlayBtn;
}

- (void)setEssenceListModel:(BSEssenceListModel *)essenceListModel{
    _essenceListModel = essenceListModel;
    NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@",essenceListModel.top_cmt.user.username,essenceListModel.top_cmt.content];
    //富文本
    NSMutableAttributedString *attributedString = [NSMutableAttributedString stringwithContent:topCmtContent desContent:essenceListModel.top_cmt.user.username fontSize:13.0f textColor:BSRGBColor(50, 95, 153)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:BSTopCmtLineParagraphMargin];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [topCmtContent length])];
    _topCmtContentLabel.attributedText = attributedString;
    
    CGFloat commentW = [topCmtContent sizeWithFont:[UIFont systemFontOfSize:13.0f] maxSize:CGSizeMake(CGFLOAT_MAX, 28)].width;
    if (commentW>BSEssenceCellContentW-2*BSEssenceCellMargin-BSALayoutH(124)) {
        commentW = BSEssenceCellContentW-2*BSEssenceCellMargin-BSALayoutH(124);
    }
    
    //约束“最热评论”文字
    [_topCmtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.size.equalTo(CGSizeMake(BSALayoutH(30*4), BSTopCmtTopMargin));
    }];
    
    if (essenceListModel.top_cmt.voiceuri.length) {
        self.voicePlayBtn.hidden = NO;
        [self.voicePlayBtn setTitle:[NSString stringWithFormat:@"%zd''", essenceListModel.top_cmt.voicetime] forState:UIControlStateNormal];
        [_topCmtContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topCmtLabel.mas_bottom).offset(BSEssenceCellMargin);
            make.left.equalTo(self).offset(BSTopCmtHMargin);
            make.width.equalTo(commentW);
            make.bottom.equalTo(self).offset(-3*BSTopCmtHMargin);
        }];
        
        [_voicePlayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(BSALayoutH(124), BSALayoutH(44)));
            make.centerY.equalTo(_topCmtContentLabel);
            make.left.equalTo(_topCmtContentLabel.mas_right).offset(BSEssenceCellMargin);
        }];
    } else {
        self.voicePlayBtn.hidden = YES;
        //约束评论内容
        [_topCmtContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topCmtLabel.mas_bottom).offset(BSEssenceCellMargin);
            make.left.equalTo(self).offset(BSTopCmtHMargin);
            make.right.equalTo(self).offset(-BSTopCmtHMargin);
            make.bottom.equalTo(self).offset(-BSTopCmtHMargin);
        }];
    }

}



@end
