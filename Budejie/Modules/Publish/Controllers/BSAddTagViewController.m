//
//  BSAddTagViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/30.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSAddTagViewController.h"
#import "BSTitlteLeftButton.h"
#import "BSTagTextField.h"

#define BSTagH 22.f
NSInteger const BSTagMax = 5;

@interface BSAddTagViewController ()<UITextFieldDelegate>
/** 内容容器 */
@property (weak, nonatomic) UIView *contentView;
/** 文本输入框 */
@property (weak, nonatomic) BSTagTextField *textF;
/** 标签提示 */
@property (weak, nonatomic) UIButton *tagTipBtn;
/** 所有标签按钮 */
@property (strong, nonatomic) NSMutableArray *allTags;
/** 所有标签 */
@property (strong, nonatomic) NSMutableArray *allTagsTitle;


@end

@implementation BSAddTagViewController

- (UIButton *)tagTipBtn{
    if (!_tagTipBtn) {
        UIButton *tagTipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagTipBtn.hidden = YES;
        tagTipBtn.layer.cornerRadius = 1.5f;
        tagTipBtn.layer.masksToBounds = YES;
        tagTipBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        tagTipBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        tagTipBtn.contentEdgeInsets = UIEdgeInsetsMake(0, BSALayoutH(10), 0, BSALayoutH(10));
        tagTipBtn.backgroundColor = BSRGBColor(74, 139, 209);
        [tagTipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:tagTipBtn];
        _tagTipBtn = tagTipBtn;
    }
    return _tagTipBtn;
}

- (NSMutableArray *)allTags{
    if (!_allTags) {
        _allTags = [NSMutableArray array];
    }
    return _allTags;
}

- (NSMutableArray *)allTagsTitle{
    if (!_allTagsTitle) {
        _allTagsTitle = [NSMutableArray array];
    }
    return _allTagsTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTagBasicConfig];
    [self initAddTagComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textF becomeFirstResponder];
}

- (void)addTagBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"添加标签"];
    self.view.backgroundColor = BSGlobalColor;
}

- (void)initAddTagComponents{
    //完成按钮
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    finishButton.frame = CGRectMake(0, 0, 18*2, 18);
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:BSGrayColor(80) forState:UIControlStateNormal];
    [finishButton setTitleColor:BSRedColor forState:UIControlStateHighlighted];
    [[finishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        for (BSTitlteLeftButton *tag in self.allTags) {
//            NSString *tagTitle = [tag titleForState:UIControlStateNormal];
//            [self.allTagsTitle addObject:tagTitle];
//            
//        }
        self.allTagsTitle = [self.allTags valueForKeyPath:@"currentTitle"];
        !self.finishEditTag?:self.finishEditTag(self.allTagsTitle);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationBar addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationBar);
        make.right.equalTo(self.navigationBar).offset(-BSMarigin);
        make.size.equalTo(CGSizeMake(18*2, 18));
    }];
    
    //内容容器
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = BSGlobalColor;
    [self.view addSubview:contentView];
    _contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BSViewOriginY + BSMarigin);
        make.left.equalTo(BSMarigin);
        make.right.bottom.equalTo(-BSMarigin);
    }];
    
    //输入框
    __weak typeof(self)  weakSelf = self;
    BSTagTextField *textF = [[BSTagTextField alloc] init];
    textF.delegate = self;
    textF.font = [UIFont systemFontOfSize:15.f];
    textF.tintColor = BSRedColor;
    textF.placeholder = @"多个标签用逗号或者换行隔开";
    textF.width = kScreenWidth - 2*BSMarigin;
    textF.height = BSTagH;
    [textF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    textF.backwardClick = ^{
        BSTitlteLeftButton *tag = [self.allTags lastObject];
        [weakSelf removeTag:tag];
    };
    [self.contentView addSubview:textF];
    _textF = textF;
    
    //提示按钮
    [self.tagTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        /*
         tagTipBtn.frame = CGRectMake(0, CGRectGetMaxY(self.textF.frame) + BSMarigin, kScreenWidth - 2*BSMarigin, 25);
         */
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.textF.mas_bottom).offset(BSMarigin);
        make.height.equalTo(25);
    }];
    
    //tagButton的点击
    [[self.tagTipBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *tagTipBtn) {
        [self addTagClick];
    }];
    
    //上一页tag的添加
    for (NSString *tag in self.tagTitles) {
        self.textF.text = tag;
        [self addTagClick];
    }
}

- (void)addTagClick{
    //限制添加tag个数
    if (self.allTags.count >= BSTagMax) {
        [MBProgressHUD showWarringWithMessage:[NSString stringWithFormat:@"最多可添加%ld个标签",(long)BSTagMax]];
    }else{
        CGFloat tagH = BSTagH;
        self.tagTipBtn.hidden = YES;
        BSTitlteLeftButton *tag = [BSTitlteLeftButton buttonWithType:UIButtonTypeCustom];
        [tag setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        NSString *tagTitle = self.textF.text;
        //清空textF的文字
        self.textF.text = nil;
        [self.tagTipBtn setTitle:nil forState:UIControlStateNormal];
        if (!tagTitle.length)return;
        CGFloat tagW = [tagTitle sizeWithFont:self.textF.font maxSize:CGSizeMake(CGFLOAT_MAX, BSTagFontSize)].width + tag.currentImage.size.width + BSMarigin*3/4;
        if (tagW>=kScreenWidth-2*BSMarigin) {
            tagW = kScreenWidth-2*BSMarigin;
        }
        tag.layer.cornerRadius = 1.5f;
        tag.layer.masksToBounds = YES;
        tag.titleLabel.font = [UIFont systemFontOfSize:BSTagFontSize];
        tag.frame = CGRectMake(0, 0, tagW, tagH);
        tag.backgroundColor = BSRGBColor(74, 139, 209);
        [tag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tag setTitle:tagTitle forState:UIControlStateNormal];
        [[tag rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(BSTitlteLeftButton *tag) {
            [self removeTag:tag];
        }];
        [self.allTags addObject:tag];
        [self.contentView addSubview:tag];
        [self updateTagFrameWithDuratiton:0.f];
        [self updateTextFieldFrameWithDuratiton:0.f];
    }
}

- (void)removeTag:(BSTitlteLeftButton *)tag{
    [tag removeFromSuperview];
    [self.allTags removeObject:tag];
    [self updateTagFrameWithDuratiton:0.25f];
    [self updateTextFieldFrameWithDuratiton:0.25f];
}

- (void)updateTagFrameWithDuratiton:(NSTimeInterval)duratiton{
    [UIView animateWithDuration:duratiton animations:^{
        //更新tagframe
        for (NSUInteger index = 0; index<self.allTags.count; index++) {
            BSTitlteLeftButton *tag = self.allTags[index];
            if (index == 0) {
                tag.x = 0;
                tag.y = 0;
            }else{
                BSTitlteLeftButton *beforeTag = self.allTags[index-1];
                CGFloat leftWidth = CGRectGetMaxX(beforeTag.frame) + BSMarigin;
                CGFloat rightWidth = kScreenWidth - 2*BSMarigin - leftWidth;
                if (rightWidth>= tag.width) {
                    tag.y = beforeTag.y;
                    tag.x = leftWidth;
                }else{
                    tag.x = 0;
                    tag.y = CGRectGetMaxY(beforeTag.frame)+BSMarigin;
                }
            }
        }
    }];
}

- (void)updateTextFieldFrameWithDuratiton:(NSTimeInterval)duratiton{
    [UIView animateWithDuration:duratiton animations:^{
        BSTitlteLeftButton *lastTag = [self.allTags lastObject];
        CGFloat textFW = [self.textF.placeholder sizeWithFont:self.textF.font maxSize:CGSizeMake(CGFLOAT_MAX, self.textF.font.pointSize)].width + 2*BSMarigin;
        CGFloat rightWidth = self.contentView.width - CGRectGetMaxX(lastTag.frame) - BSMarigin;
        if (rightWidth>textFW) {
            self.textF.x = CGRectGetMaxX(lastTag.frame) + BSMarigin;
            self.textF.y = lastTag.y;
        }else{
            self.textF.x = 0;
            self.textF.y = CGRectGetMaxY(lastTag.frame) + BSMarigin;
        }
    }];
}


- (void)textChange{
    if ([self.textF hasText]) {
        self.tagTipBtn.hidden = NO;
        NSString *tagTip = [NSString stringWithFormat:@"添加标签：%@",self.textF.text];
        [self.tagTipBtn setTitle:tagTip forState:UIControlStateNormal];
    }else{
        self.tagTipBtn.hidden = YES;
    }
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addTagClick];
    return YES;
}


@end
