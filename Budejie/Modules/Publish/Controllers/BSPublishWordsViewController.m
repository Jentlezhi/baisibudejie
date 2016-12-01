//
//  BSPublishWordsViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSPublishWordsViewController.h"
#import "BSPlaceHolderTextView.h"
#import "BSInputToolbar.h"

@interface BSPublishWordsViewController ()<UITextViewDelegate>
/** 发布按钮 */
@property(weak, nonatomic) UIButton *publishButton;
/** 文本输入框 */
@property(weak, nonatomic) BSPlaceHolderTextView *textView;
/** 工具条 */
@property(weak, nonatomic) BSInputToolbar *toolbar;

@end

@implementation BSPublishWordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self publishWordsBasicConfig];
    [self publishWordsInitComponents];
    [self configInputToolbar];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

/**
 *  基本配置
 */
- (void)publishWordsBasicConfig{
    self.view.backgroundColor = BSGlobalColor;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    cancelButton.frame = CGRectMake(0, 0, 18*2, 18);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:BSGrayColor(80) forState:UIControlStateNormal];
    [cancelButton setTitleColor:BSRedColor forState:UIControlStateHighlighted];
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.enabled = NO;
    publishButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    publishButton.frame = CGRectMake(0, 0, 18*2, 18);
    [publishButton setTitle:@"发表" forState:UIControlStateNormal];
    [publishButton setTitleColor:BSGrayColor(80) forState:UIControlStateNormal];
    [publishButton setTitleColor:BSRedColor forState:UIControlStateHighlighted];
    [publishButton setTitleColor:BSGrayColor(200) forState:UIControlStateDisabled];
    
    UILabel *titleView = [[UILabel alloc] init];
    titleView.text = @"发表文字";
    titleView.frame = CGRectMake(0, 0, 20*4, 20);
    
    [self createNavBarWithLeftButton:cancelButton titleView:titleView andRightButton:publishButton];
    _publishButton = publishButton;
    
    //监听键盘的升起和降落
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, frame.origin.y - kScreenHeight);
    
    }];
}


- (void)leftButtonClick:(UIButton *)rightButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  初始化子控件
 */
- (void)publishWordsInitComponents{
    //添加输入框
    BSPlaceHolderTextView *textView = [[BSPlaceHolderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.delegate = self;
    [self.view addSubview:textView];
    _textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(BSEssenceCellMargin);
        make.right.bottom.equalTo(self.view).offset(-BSEssenceCellMargin);
        make.top.equalTo(self.view).offset(BSViewOriginY);
    }];
    
    [textView.rac_textSignal subscribeNext:^(NSString *text) {
        self.publishButton.enabled = [textView hasText];
    }];
}

- (void)configInputToolbar{
    BSInputToolbar *toolbar = [[BSInputToolbar alloc] init];
    CGFloat toolbarW = kScreenWidth;
    CGFloat toolbarH = BSALayoutV(200);
    CGFloat toolbarX = 0;
    CGFloat toolbarY = kScreenHeight - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    _toolbar = toolbar;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
