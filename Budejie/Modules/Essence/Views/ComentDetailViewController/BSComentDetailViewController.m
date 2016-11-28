//
//  BSComentDetailViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSComentDetailViewController.h"
#import "BSBaseCell.h"
#import "BSEssenceListModel.h"
#import "BSCmtDetailParameter.h"
#import "BSCmtNetworkTool.h"
#import "BSCmtSectionHeader.h"
#import "BSCommentCell.h"
#import "BSCommentModel.h"
#import "BSShowBigPicViewController.h"
#import "BSUserModel.h"

@interface BSComentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 评论列表 */
@property(strong, nonatomic) UITableView *comentDetailTableView;
/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 底部工具条 */
@property (nonatomic, weak) UIImageView *toolBar;
/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;
/** 当前点击的cell的indexPath */
@property (nonatomic, strong) NSIndexPath *clickIndexPath;

@end

@implementation BSComentDetailViewController
- (NSArray *)hotComments{
    if (!_hotComments) {
        _hotComments = [NSArray array];
    }
    return _hotComments;
}

- (NSArray *)latestComments{
    if (!_latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}

- (UITableView *)comentDetailTableView{
    if (!_comentDetailTableView) {
        _comentDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _comentDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _comentDetailTableView.tableFooterView = [[UIView alloc] init];
        _comentDetailTableView.contentInset = UIEdgeInsetsMake(BSViewOriginY, 0, BSNavigationBarHeight+BSEssenceCellMargin, 0);
        _comentDetailTableView.backgroundColor = BSGlobalColor;
        _comentDetailTableView.delegate = self;
        _comentDetailTableView.dataSource = self;
        _comentDetailTableView.sectionHeaderHeight = BSALayoutV(40);
        _comentDetailTableView.estimatedRowHeight = BSViewOriginY;
        _comentDetailTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _comentDetailTableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self comentDetailBasicConfig];
    [self initComentDetailComponents];
    [self requestCmtDetailList];
}
/**
 *  基本配置
 */
- (void)comentDetailBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"评论"];
    self.view.backgroundColor = BSGlobalColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [_toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(frame.origin.y-kScreenHeight);
        make.height.equalTo(BSNavigationBarHeight);
    }];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    UIMenuController *menu = [UIMenuController sharedMenuController]
    ;
    [menu setMenuVisible:NO animated:YES];
}



/**
 *  初始化子控件
 */
- (void)initComentDetailComponents{
    //添加标签列表
    [self.view insertSubview:self.comentDetailTableView belowSubview:self.navigationZone];
    [self.comentDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
    
    //添加headerView
    UIView *headerView = [[UIView alloc] init];
    headerView.clipsToBounds = YES;
    headerView.backgroundColor = [UIColor clearColor];
    CGFloat hotCmtH = self.essenceListModel.topCmtF.size.height;
    headerView.height = self.essenceListModel.cellHeight - hotCmtH;
    
    BSBaseCell *cell = [[BSBaseCell alloc] init];
    
    cell.essenceListModel = self.essenceListModel;
    //移除原本cell的热门评论
    UIView *commentView = [cell valueForKey:BSCommentViewKey];
    [commentView removeFromSuperview];
    cell.size = headerView.size;
    
    //查看大图
    cell.seeBigPicBlock = ^(BSEssenceListModel *essenceListModel){
        BSShowBigPicViewController *showBigPicViewController = [BSShowBigPicViewController showBigPicViewController];
        showBigPicViewController.essenceListModel = essenceListModel;
        //直接用self调用会循环引用
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBigPicViewController animated:NO completion:nil];
    };

    [headerView addSubview:cell];
    self.comentDetailTableView.tableHeaderView = headerView;

    //底部工具条
    UIImageView *toolBar = [[UIImageView alloc] init];
    toolBar.userInteractionEnabled = YES;
    toolBar.image = [UIImage imageNamed:@"comment-bar-bg"];
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(BSNavigationBarHeight);
    }];
    
    //语音按钮
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceBtn setImage:[UIImage imageNamed:@"comment-bar-voice"] forState:UIControlStateNormal];
    voiceBtn.adjustsImageWhenHighlighted = NO;
    [toolBar addSubview:voiceBtn];
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(toolBar);
        make.width.equalTo(BSNavigationBarHeight);
    }];
    
    //@按钮
    UIButton *atBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [atBtn setImage:[UIImage imageNamed:@"comment_bar_at_icon"] forState:UIControlStateNormal];
    atBtn.adjustsImageWhenHighlighted = NO;
    [toolBar addSubview:atBtn];
    [atBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(toolBar);
        make.width.equalTo(BSNavigationBarHeight);
    }];
    
    //输入框
    UITextField *inputTF = [[UITextField alloc] init];
    inputTF.placeholder = @"写评论...";
    inputTF.borderStyle = UITextBorderStyleRoundedRect;
    inputTF.backgroundColor = [UIColor whiteColor];
    inputTF.font = [UIFont systemFontOfSize:14.0f];
    [toolBar addSubview:inputTF];
    [inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(voiceBtn.mas_right);
        make.right.equalTo(atBtn.mas_left);
        make.top.equalTo(toolBar).offset(BSALayoutH(10));
        make.bottom.equalTo(toolBar).offset(-BSALayoutH(10));
    }];
    
    
}

/**
 *  请求数据
 */
- (void)requestCmtDetailList{
    __weak typeof(self) weakSelf = self;
    //加载更多
    self.comentDetailTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestCmtListWithType:BSRequestTypeLoadMore];
    }];
    
    //刷新数据
    self.comentDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf requestCmtListWithType:BSRequestTypeRefresh];
    }];
    
    [self.comentDetailTableView.mj_header beginRefreshing];
}

- (void)requestCmtListWithType:(BSRequestType)requestType{
    [self.sessionDateTask cancel];
    requestType == BSRequestTypeRefresh?self.currentPage=1:self.currentPage++;
    
    __weak typeof(self) weakSelf = self;
    BSCmtDetailParameter *cmtDetailParameter = [[BSCmtDetailParameter alloc] init];
    cmtDetailParameter.a = @"dataList";
    cmtDetailParameter.c = @"comment";
    cmtDetailParameter.hot = @"1";
    cmtDetailParameter.data_id = weakSelf.essenceListModel.ID;
    cmtDetailParameter.page = self.currentPage;
    if (requestType == BSRequestTypeLoadMore) {
        BSCommentModel *commentModel = [weakSelf.latestComments lastObject];
        cmtDetailParameter.lastid = commentModel.ID;
    }
    
   self.sessionDateTask = [BSCmtNetworkTool cmtWithParameters:cmtDetailParameter success:^(BSCmtDetailResult *result) {
        weakSelf.hotComments = result.hot;
        NSInteger lastCmtTotal = [result.total integerValue];
        if (requestType == BSRequestTypeRefresh) {
            [weakSelf.comentDetailTableView.mj_header endRefreshing];
            [weakSelf.latestComments removeAllObjects];
        }
        if (!result.data.count) {
            self.currentPage--;
        }else{
            [weakSelf.latestComments addObjectsFromArray:result.data];
        }
        //footer状态设置
        if (weakSelf.latestComments.count>=lastCmtTotal) {
            [weakSelf.comentDetailTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.comentDetailTableView.mj_footer endRefreshing];
        }
        
        [weakSelf.comentDetailTableView reloadData];

    } failure:^(NSError *error) {
        weakSelf.currentPage--;
        [weakSelf.comentDetailTableView.mj_header endRefreshing];
        [weakSelf.comentDetailTableView.mj_footer endRefreshing];
        BSLog(@"%@",error);
        [MBProgressHUD showErrorWithMessage:@"数据加载失败"];
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BSCommentCell *cell = [BSCommentCell commentCellForTableView:tableView indexPath:indexPath];
    cell.commentModel = [self commentModelInIndexPath:indexPath];
    return cell;
}

#pragma mark - <UITableViewDelegate>

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSCommentModel *commentModel = [[BSCommentModel alloc] init];
//    if (indexPath.section == 0) {
//        commentModel = self.hotComments.count ? self.hotComments[indexPath.row] : self.latestComments[indexPath.row];
//    }else{
//        commentModel = self.latestComments[indexPath.row];
//    }
//    return commentModel.cellHeight;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BSCmtSectionHeader *header = [BSCmtSectionHeader cmtSectionHeaderWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.sectionTitle = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.sectionTitle = @"最新评论";
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.clickIndexPath = indexPath;
    BSCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIMenuController *menu = [UIMenuController sharedMenuController]
    ;
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding,replay,report];
        UILabel *content = [cell valueForKeyPath:@"contentLabel"];
        [menu setTargetRect:CGRectMake(0, 0, content.width*0.5, content.height) inView:content];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)ding:(UIMenuItem*)menu{
    BSCommentModel *commentModel = [self commentModelInIndexPath:self.clickIndexPath];
    BSLog(@"顶->%@",commentModel.user.username);
}
- (void)replay:(UIMenuItem*)menu{
    BSCommentModel *commentModel = [self commentModelInIndexPath:self.clickIndexPath];
    BSLog(@"回复->%@",commentModel.user.username);
}
- (void)report:(UIMenuItem*)menu{
    BSCommentModel *commentModel = [self commentModelInIndexPath:self.clickIndexPath];
    BSLog(@"举报->%@",commentModel.user.username);
}

- (BSCommentModel *)commentModelInIndexPath:(NSIndexPath *)indexPath{
    BSCommentModel *commentModel = [[BSCommentModel alloc] init];;
    if (indexPath.section == 0) {
        commentModel = self.hotComments.count ? self.hotComments[indexPath.row] : self.latestComments[indexPath.row];
    }else{
        commentModel = self.latestComments[indexPath.row];
    }
    return commentModel;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.view = nil;
}
- (void)dealloc{
    BSLogFunc;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self cancelRequest];
}




@end
