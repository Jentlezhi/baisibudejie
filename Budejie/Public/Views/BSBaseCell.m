//
//  BSBaseCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/18.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseCell.h"
#import "BSToolbarButton.h"
#import "BSEssenceListModel.h"
#import "BSEssencePictureView.h"

@interface BSBaseCell()

/** 用户头像 */
@property(weak, nonatomic) UIImageView *userHeaderImgv;
/** 认证加V */
@property(weak, nonatomic) UIImageView *addv;
/** 用户昵称 */
@property(weak, nonatomic) UILabel *nikenameLabel;
/** 发帖子时间 */
@property(weak, nonatomic) UILabel *sendTimeLabel;
/** 关注按钮 */
@property(weak, nonatomic) UIButton *attendBtn;
/** 内容 */
@property(weak, nonatomic) UILabel *contentLabel;
/** 图片 */
@property(weak, nonatomic) BSEssencePictureView *essencePictureView;
/** 工具条 */
@property(weak, nonatomic) UIView *toolBar;
/** 点赞 */
@property(weak, nonatomic) UIButton *praiseBtn;
/** 踩 */
@property(weak, nonatomic) UIButton *stampBtn;
/** 分享 */
@property(weak, nonatomic) UIButton *shareBtn;
/** 评论 */
@property(weak, nonatomic) UIButton *commentBtn;


@end

@implementation BSBaseCell
- (BSEssencePictureView *)essencePictureView{
    if (!_essencePictureView) {
        BSEssencePictureView *essencePictureView = [[BSEssencePictureView alloc] init];
        [essencePictureView.seeBigPicSignal subscribeNext:^(BSEssenceListModel *essenceListModel) {
            if (self.seeBigPicBlock) {
                self.seeBigPicBlock(essenceListModel);
            }
        }];
        [self.contentView addSubview:essencePictureView];
        _essencePictureView = essencePictureView;
    }
    return _essencePictureView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self baseCellCellBasicConfig];
        [self initBaseCellComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)baseCellCellBasicConfig{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    //选中不变色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    //cell选中时颜色设置
//    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
//    self.selectedBackgroundView.backgroundColor = BSGlobalColor;
    //添加长按分享
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    [[longPress rac_gestureSignal] subscribeNext:^(UILongPressGestureRecognizer *longPress) {
        BSLog(@"%ld",(long)longPress.state);
        /*
         UIGestureRecognizerStateBegan = 开始长按的时候调用
         UIGestureRecognizerStateEnded = 结束长按的时候调用
         */
        if (longPress.state == UIGestureRecognizerStateBegan) {
            BSLog(@"长按了->%@",self.essenceListModel);
        }
        
    }];
    [self.contentView addGestureRecognizer:longPress];
    
}
/**
 *  初始化子控件
 */
- (void)initBaseCellComponents{
    //用户头像
    CGFloat userHeaderImgvWH = BSALayoutH(70);
    UIImageView *userHeaderImgv = [[UIImageView alloc] init];
    userHeaderImgv.layer.cornerRadius = userHeaderImgvWH*0.5;
    userHeaderImgv.layer.masksToBounds = YES;
    [self.contentView addSubview:userHeaderImgv];
    _userHeaderImgv = userHeaderImgv;
    [userHeaderImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(userHeaderImgvWH, userHeaderImgvWH));
        make.left.top.equalTo(self.contentView).offset(BSEssenceCellMargin);
    }];
    
    //认证加V
    CGFloat addvWH = BSALayoutH(24);
    UIImageView *addv = [[UIImageView alloc] init];
    [addv setImage:[UIImage imageNamed:@"Profile_AddV_authen"]];
    addv.layer.cornerRadius = addvWH*0.5;
    addv.layer.masksToBounds = YES;
    [self.contentView addSubview:addv];
    _addv = addv;
    [addv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(userHeaderImgv);
        make.size.equalTo(CGSizeMake(addvWH, addvWH));
    }];
    
    //关注按钮
    UIButton *attendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [attendBtn setBackgroundImage:[UIImage imageNamed:@"cellFollowIcon"] forState:UIControlStateNormal];
    [attendBtn setBackgroundImage:[UIImage imageNamed:@"cellFollowClickIcon"] forState:UIControlStateHighlighted];
    [[attendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.attendBtnClick) {
            self.attendBtnClick(self.essenceListModel);
        }
    }];
    [self.contentView addSubview:attendBtn];
    [attendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userHeaderImgv);
        make.size.equalTo(CGSizeMake(BSALayoutV(38), BSALayoutV(40)));
        make.right.equalTo(self.contentView).offset(-BSEssenceCellMargin);
    }];
    
    //用户昵称
    UILabel *nikenameLabel = [[UILabel alloc] init];
    nikenameLabel.textColor = BSRGBColor(67, 67, 67);
    nikenameLabel.font = [UIFont systemFontOfSize:14];
    nikenameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:nikenameLabel];
    _nikenameLabel = nikenameLabel;
    [nikenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userHeaderImgv.mas_top);
        make.left.equalTo(userHeaderImgv.mas_right).offset(BSALayoutH(10));
        make.right.equalTo(attendBtn.mas_left).offset(-BSEssenceCellMargin);
        make.height.equalTo(nikenameLabel.font.pointSize);
    }];
    //发帖子时间
    UILabel *sendTimeLabel = [[UILabel alloc] init];
    sendTimeLabel.textColor = BSRGBColor(132, 132, 132);
    sendTimeLabel.font = [UIFont systemFontOfSize:11];
    sendTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:sendTimeLabel];
    _sendTimeLabel = sendTimeLabel;
    [sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(nikenameLabel);
        make.bottom.equalTo(userHeaderImgv);
        make.height.equalTo(nikenameLabel.font.pointSize);
    }];
    //文字内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = BSRGBColor(0, 0, 0);
    contentLabel.font = BSEssenceTextFont;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userHeaderImgv.mas_bottom).offset(BSEssenceCellMargin);
        make.left.equalTo(self.contentView).offset(BSEssenceCellMargin);
        make.right.equalTo(self.contentView).offset(-BSEssenceCellMargin);
    }];

    //工具条
    CGFloat toolBarButtonW = (kScreenWidth-2*BSALayoutH(20))/4;
    UIView *toolBar = [[UIView alloc] init];
    toolBar.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:toolBar];
    _toolBar = toolBar;
    
    //点赞
    BSToolbarButton *praiseBtn = [BSToolbarButton buttonWithType:UIButtonTypeCustom];
    [praiseBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [praiseBtn setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:UIControlStateHighlighted];
    [[praiseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.praiseBtnClick) {
            self.praiseBtnClick(self.essenceListModel);
        }
    }];
    [toolBar addSubview:praiseBtn];
    _praiseBtn = praiseBtn;
    [praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(toolBar);
        make.width.equalTo(toolBarButtonW);
    }];
    
    //踩
    BSToolbarButton *stampBtn = [BSToolbarButton buttonWithType:UIButtonTypeCustom];
    [stampBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    [stampBtn setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:UIControlStateHighlighted];
    [[stampBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.stampBtnClick) {
            self.stampBtnClick(self.essenceListModel);
        }
    }];
    [toolBar addSubview:stampBtn];
    _stampBtn = stampBtn;
    [stampBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(praiseBtn.mas_right);
        make.top.bottom.equalTo(toolBar);
        make.width.equalTo(toolBarButtonW);
    }];
    
    //分享
    BSToolbarButton *shareBtn = [BSToolbarButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"mainCellShareClick"] forState:UIControlStateHighlighted];
    [[shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.shareBtnClick) {
            self.shareBtnClick(self.essenceListModel);
        }
    }];
    [toolBar addSubview:shareBtn];
    _shareBtn = shareBtn;
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stampBtn.mas_right);
        make.top.bottom.equalTo(toolBar);
        make.width.equalTo(toolBarButtonW);
    }];
    
    //评论
    BSToolbarButton *commentBtn = [BSToolbarButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"mainCellCommentClick"] forState:UIControlStateHighlighted];
    [[commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.commentBtnClick) {
            self.commentBtnClick(self.essenceListModel);
        }
    }];
    [toolBar addSubview:commentBtn];
    _commentBtn = commentBtn;
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shareBtn.mas_right);
        make.top.bottom.equalTo(toolBar);
        make.width.equalTo(toolBarButtonW);
    }];
}

/**
 * 设置cell内边距
 */
-(void)setFrame:(CGRect)frame{
    CGFloat margin = BSEssenceCellMargin;
    frame.origin.x = margin;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}

- (void)setToolBarButtonTitle:(UIButton *)btn count:(NSInteger)count{
    NSString *title = [NSString string];
    if (count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        title = [NSString stringWithFormat:@"%zd", count];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setEssenceListModel:(BSEssenceListModel *)essenceListModel{
    _essenceListModel = essenceListModel;
    [_userHeaderImgv sd_setImageWithURL:[NSURL URLWithString:essenceListModel.profile_image]];
    _addv.hidden = !essenceListModel.isSina_v;
    _nikenameLabel.text = essenceListModel.name;
    _sendTimeLabel.text = essenceListModel.create_time;
    _contentLabel.text = essenceListModel.text;
    [self setToolBarButtonTitle:_praiseBtn count:essenceListModel.ding];
    [self setToolBarButtonTitle:_stampBtn count:essenceListModel.cai];
    [self setToolBarButtonTitle:_shareBtn count:essenceListModel.repost];
    [self setToolBarButtonTitle:_commentBtn count:essenceListModel.comment];
    
    //图片
    if (essenceListModel.type == BSTopicTypePicture) {
        self.essencePictureView.essenceListModel = essenceListModel;
        //添加约束
        [self.essencePictureView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(2*BSEssenceCellMargin);
            make.left.right.equalTo(self.contentLabel);
            make.height.equalTo(essenceListModel.pictureF.size.height);
        }];
        
        //工具条更改约束
        [self.toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(_essencePictureView.mas_bottom).offset(BSEssenceCellMargin);
            make.height.equalTo(BSALayoutV(80));
        }];
    }else{
        self.essencePictureView.hidden = YES;
        [self.toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentLabel.mas_bottom);
            make.height.equalTo(BSALayoutV(80));
        }];
    }
}

+ (instancetype)baseCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSBaseCellID";
    BSBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
