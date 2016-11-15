//
//  BSLeftTagCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSLeftTagCell.h"
#import "BSLeftTagModel.h"

@interface BSLeftTagCell ()

/** 选中标识 */
@property(weak, nonatomic) UIImageView *selectedView;
/** 标签 */
@property(weak, nonatomic) UILabel *tagLabel;

@end

@implementation BSLeftTagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self leftTagCellBasicConfig];
        [self initLeftTagCellComponents];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)leftTagCellBasicConfig{
    self.backgroundColor = BSGlobalColor;
    
}
/**
 *  初始化子控件
 */
- (void)initLeftTagCellComponents{
    //选中标识
    UIImageView *selectedView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:BSRedColor]];
    selectedView.hidden = YES;
    [self.contentView addSubview:selectedView];
    _selectedView = selectedView;
    [selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.width.equalTo(BSALayoutH(5));
    }];
    
    //标签
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.font = [UIFont systemFontOfSize:16];
    tagLabel.textColor = BSRGBColor(33, 33, 33);
    tagLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:tagLabel];
    _tagLabel = tagLabel;
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.contentView);
        make.left.equalTo(_selectedView.mas_right);
    }];
    
    //分割线
    UILabel *dividerLine = [[UILabel alloc] init];
    dividerLine.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:dividerLine];
    [dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(BSDividerHeight);
    }];
    
}

+ (instancetype)leftTagCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSLeftTagCellID";
    BSLeftTagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSLeftTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setLeftTagModel:(BSLeftTagModel *)leftTagModel{
    _leftTagModel = leftTagModel;
    self.tagLabel.text = leftTagModel.name;
}
/**
 *  标签的点击
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (selected) {
        self.selectedView.hidden = NO;
        self.tagLabel.textColor = BSRedColor;
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.selectedView.hidden = YES;
        self.tagLabel.textColor = BSRGBColor(33, 33, 33);
        self.backgroundColor = BSGlobalColor;
    }
}

@end
