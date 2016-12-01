//
//  BSInputToolbar.m
//  Budejie
//
//  Created by Jentle on 2016/11/30.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSInputToolbar.h"
#import "BSAddTagViewController.h"

#define BSToolbarHeight BSALayoutV(70)

@interface BSInputToolbar()

@property (weak, nonatomic) UIView *tagsView;
@property (strong, nonatomic) NSMutableArray *tagLabels;
@property (weak, nonatomic) UIButton *addBtn;

@end

@implementation BSInputToolbar

- (NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BSGlobalColor;
        [self initInputViewComponents];
    }
    return self;
}

- (void)initInputViewComponents{
    //工具条
    UIView *bar = [[UIView alloc] init];
    bar.backgroundColor = BSGrayColor(230);
    [self addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(BSToolbarHeight);
    }];
    
    //工具条按钮
    UIButton *atBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    atBtn.adjustsImageWhenHighlighted = NO;
    [atBtn setImage:[UIImage imageNamed:@"post-@"] forState:UIControlStateNormal];
    [bar addSubview:atBtn];
    [atBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bar);
        make.width.equalTo(BSToolbarHeight);
    }];
    
    UIButton *jingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jingBtn.adjustsImageWhenHighlighted = NO;
    [jingBtn setImage:[UIImage imageNamed:@"post-#"] forState:UIControlStateNormal];
    [bar addSubview:jingBtn];
    [jingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(atBtn.mas_right);
        make.top.bottom.equalTo(bar);
        make.width.equalTo(BSToolbarHeight);
    }];
    
    //标签内容视图
    UIView *tagsView = [[UIView alloc] init];
    tagsView.backgroundColor = [UIColor clearColor];
    [self addSubview:tagsView];
    _tagsView = tagsView;
    [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(BSEssenceCellMargin);
        make.right.equalTo(self).offset(-BSEssenceCellMargin);
        make.bottom.equalTo(bar.mas_top);
    }];
    
    //加号按钮
    __weak typeof(self) weakSelf = self;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.adjustsImageWhenHighlighted = NO;
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSAddTagViewController *addTagVC = [[BSAddTagViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)BSRootViewController.presentedViewController;
        addTagVC.tagTitles = [self.tagLabels valueForKeyPath:@"text"];
        addTagVC.finishEditTag = ^(NSArray *allTagTitles){
            [weakSelf initTagsWithTagTitle:allTagTitles];
            //更新自己的高度
            self.height = self.barHeight;
        };
        [nav pushViewController:addTagVC animated:YES];
    }];
    [tagsView addSubview:addBtn];
    _addBtn = addBtn;
    CGFloat addBtnX = 0;
    CGFloat addBtnY = 0;
    CGFloat addBtnW = addBtn.currentImage.size.width;
    CGFloat addBtnH = addBtn.currentImage.size.height;
    addBtn.frame = CGRectMake(addBtnX, addBtnY, addBtnW, addBtnH);
}

- (void)initTagsWithTagTitle:(NSArray *)tagTitles{
    //清除之前的label
//    for (UILabel *tagLabel in self.tagLabels) {
//        [tagLabel removeFromSuperview];
//    }
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    [self.tagLabels removeAllObjects];
    //添加已选tag
    for (NSUInteger index = 0; index<tagTitles.count; index++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.backgroundColor = BSRGBColor(74, 139, 209);
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.font = [UIFont systemFontOfSize:BSTagFontSize];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        NSString *tagLabelText = tagTitles[index];
        tagLabel.text = tagLabelText;
        tagLabel.width = [tagLabelText sizeWithFont:tagLabel.font maxSize:CGSizeMake(CGFLOAT_MAX, BSTagFontSize)].width + BSEssenceCellMargin;
        tagLabel.height = 22.f;
        [self.tagLabels addObject:tagLabel];
        [self.tagsView addSubview:tagLabel];
    }
    //更新tagframe
    [self updateTagFrame];

}

- (void)updateTagFrame{
    [UIView animateWithDuration:0.25f animations:^{
        for (NSUInteger index = 0; index<self.tagLabels.count; index++) {
            UILabel *tagLabel = self.tagLabels[index];
            if (index == 0) {
                tagLabel.x = 0;
                tagLabel.y = 0;
            }else{
                UILabel *beforeTagLabel = self.tagLabels[index-1];
                CGFloat leftWidth = CGRectGetMaxX(beforeTagLabel.frame) + BSEssenceCellMargin;
                CGFloat rightWidth = self.tagsView.width - leftWidth;
                if (rightWidth>= tagLabel.width) {
                    tagLabel.y = beforeTagLabel.y;
                    tagLabel.x = leftWidth;
                }else{
                    tagLabel.x = 0;
                    tagLabel.y = CGRectGetMaxY(beforeTagLabel.frame)+BSEssenceCellMargin;
                }
            }
            //更新添加按钮fram
            UILabel *lastTagLabel = [self.tagLabels lastObject];
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + BSEssenceCellMargin;
            CGFloat rightWidth = self.tagsView.width - leftWidth;
            if (rightWidth>self.addBtn.width) {
                self.addBtn.y = lastTagLabel.y;
                self.addBtn.x = leftWidth;
            }else{
                self.addBtn.x = 0;
                self.addBtn.y = CGRectGetMaxY(lastTagLabel.frame)+BSEssenceCellMargin;
            }
        }

    }];
}

- (CGFloat)barHeight{
    return CGRectGetMaxY(self.addBtn.frame) + 2*BSEssenceCellMargin + BSToolbarHeight;
}

@end
