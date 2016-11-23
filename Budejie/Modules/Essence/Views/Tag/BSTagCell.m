//
//  BSTagCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTagCell.h"
#import "BSTagModel.h"

@interface BSTagCell()

/** 用户头像 */
@property(weak, nonatomic) UIImageView *userHeaderImgv;
/** 所推荐的用户昵称 */
@property(weak, nonatomic) UILabel *screenNameLabel;
/** 所推荐用户的被关注量 */
@property(weak, nonatomic) UILabel *fansCountLabel;

@end

@implementation BSTagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self userGroupCellBasicConfig];
        [self initUserGroupCellComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)userGroupCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    //cell选中时颜色设置
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = BSGlobalColor;
}
/**
 *  初始化子控件
 */
- (void)initUserGroupCellComponents{
    //用户头像
    CGFloat userHeaderImgvWH = BSALayoutH(90);
    UIImageView *userHeaderImgv = [[UIImageView alloc] init];
    userHeaderImgv = userHeaderImgv;
    userHeaderImgv.layer.cornerRadius = userHeaderImgvWH*0.5;
    userHeaderImgv.layer.masksToBounds = YES;
    [self.contentView addSubview:userHeaderImgv];
    _userHeaderImgv = userHeaderImgv;
    [userHeaderImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(userHeaderImgvWH, userHeaderImgvWH));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(BSALayoutH(10));
    }];
    
    
    //关注按钮
    UIButton *attentionBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"FollowBtnBg"] highlightImage:[UIImage imageNamed:@"FollowBtnClickBg"]];
    [attentionBtn setTitleColor:BSRedColor forState:UIControlStateNormal];
    [attentionBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [[attentionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.acctionBtnClick) {
            self.acctionBtnClick(self.tagModel);
        }
    }];
    [self.contentView addSubview:attentionBtn];
    [attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BSALayoutH(100), BSALayoutV(50)));
        make.right.equalTo(self.contentView).offset(-BSALayoutH(35));
        make.centerY.equalTo(self.contentView);
    }];
    
    
    //用户昵称
    UILabel *screenNameLabel = [[UILabel alloc] init];
    screenNameLabel.textColor = BSRGBColor(34, 34, 34);
    screenNameLabel.font = [UIFont systemFontOfSize:15];
    screenNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:screenNameLabel];
    _screenNameLabel = screenNameLabel;
    [screenNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userHeaderImgv.mas_top);
        make.left.equalTo(userHeaderImgv.mas_right).offset(BSALayoutH(10));
        make.right.equalTo(attentionBtn.mas_left).offset(-BSALayoutH(10));
        make.height.equalTo(screenNameLabel.font.pointSize);
    }];
    
    //被关注数
    UILabel *fansCountLabel = [[UILabel alloc] init];
    fansCountLabel.textColor = BSRGBColor(117, 117, 117);
    fansCountLabel.font = [UIFont systemFontOfSize:13];
    fansCountLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:fansCountLabel];
    _fansCountLabel = fansCountLabel;
    [fansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userHeaderImgv.mas_bottom);
        make.left.equalTo(screenNameLabel.mas_left);
        make.right.equalTo(attentionBtn.mas_left);
        make.height.equalTo(fansCountLabel.font.pointSize);
    }];
    
    //分割线
    UILabel *dividerLabel = [[UILabel alloc] init];
    dividerLabel.backgroundColor = BSGlobalColor;
    [self.contentView addSubview:dividerLabel];
    [dividerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(BSDividerHeight);
    }];
}

+ (instancetype)tagCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSTagCellID";
    BSTagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setTagModel:(BSTagModel *)tagModel{
    _tagModel = tagModel;
    NSString *userHeader = [tagModel.image_list stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.userHeaderImgv sd_setImageWithURL:[NSURL URLWithString:userHeader] placeholderImage:BSUserHeaderPlaceholder];
    self.screenNameLabel.text = tagModel.theme_name?tagModel.theme_name:@"未设置";
    NSString *subNumber = nil;
    if ([tagModel.sub_number integerValue] < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", tagModel.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", [tagModel.sub_number integerValue]/ 10000.0];
    }
    self.fansCountLabel.text = subNumber;
}


@end
