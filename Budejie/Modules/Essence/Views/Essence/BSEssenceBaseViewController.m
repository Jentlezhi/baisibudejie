//
//  BSEssenceBaseViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceBaseViewController.h"
#import "BSEssenceNetworkTool.h"
#import "BSEssenceListModel.h"
#import "BSInfoModel.h"
#import "BSBaseCell.h"
#import "BSShowBigPicViewController.h"

@interface BSEssenceBaseViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 表格视图 */
@property(strong,nonatomic)UITableView *essenceTableView;
/** 段子数据 */
@property(strong,nonatomic)NSMutableArray *essenceData;
/** 当前页 */
@property(assign,nonatomic)NSInteger curentPage;
/** 每次加载下一页的时候，需要传入上一页返回参数中对应的此内容 */
@property(copy,nonatomic)NSString *maxtime;
/** 请求参数 */
@property(strong,nonatomic)BSEssenceParameter *essenceParameter;

@end

@implementation BSEssenceBaseViewController

+ (instancetype)essenceBaseViewController{
    return [[self alloc] init];
}

- (UITableView *)essenceTableView{
    if (!_essenceTableView) {
        _essenceTableView = [[UITableView alloc] init];
        _essenceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _essenceTableView.tableFooterView = [[UIView alloc] init];
        _essenceTableView.contentInset = UIEdgeInsetsMake(BSALayoutH(70)+BSViewOriginY, 0, BSTabBarHeight, 0);
        _essenceTableView.scrollIndicatorInsets = _essenceTableView.contentInset;
        _essenceTableView.backgroundColor = BSGlobalColor;
        _essenceTableView.delegate = self;
        _essenceTableView.dataSource = self;
        _essenceTableView.rowHeight = BSALayoutV(200);
    }
    return _essenceTableView;
}
- (void)setEssenceParameter:(BSEssenceParameter *)essenceParameter{
    _essenceParameter = [BSEssenceParameter essenceParameter];
    _essenceParameter = essenceParameter;
}


- (NSMutableArray *)essenceData
{
    if (!_essenceData) {
        _essenceData = [NSMutableArray array];
    }
    return _essenceData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self essenceInitComponents];
    [self refreshEssenceList];
}
/**
 *  初始化子控件
 */
- (void)essenceInitComponents{
    //添加列表
    [self.view addSubview:self.essenceTableView];
    [self.essenceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

/**
 * 刷新数据
 */
- (void)refreshEssenceList{
    __weak typeof(self) weakSelf = self;
    //加载更多
    self.essenceTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.curentPage ++;
        [weakSelf requestJokeListWithPage:self.curentPage];
    }];
    
    //刷新数据
    self.essenceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.curentPage = 0;
        [weakSelf requestJokeListWithPage:self.curentPage];
    }];
    self.essenceTableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.essenceTableView.mj_header beginRefreshing];
    
}

- (void)requestJokeListWithPage:(NSInteger)page{
    BSEssenceParameter *essenceParameter = [BSEssenceParameter essenceParameter];
    essenceParameter.a = @"list";
    essenceParameter.c = @"data";
    essenceParameter.type = self.type;
    essenceParameter.page = page;
    essenceParameter.maxtime = page==0?nil:self.maxtime;
    self.essenceParameter = essenceParameter;
    //请求前先结束上次刷新
    if (page == 0) {
        [self.essenceTableView.mj_footer endRefreshing];
    }else{
        [self.essenceTableView.mj_header endRefreshing];
    }
    [BSEssenceNetworkTool essenceWithParameters:essenceParameter success:^(BSEssenceResult *result) {
        //发现两次请求不一样
        if (self.essenceParameter!= essenceParameter) return;
        self.maxtime = result.info.maxtime;
        if (page==0) {//刷新数据
            [self.essenceTableView.mj_header endRefreshing];
            [self.essenceData removeAllObjects];
        }else{
            [self.essenceTableView.mj_footer endRefreshing];
        }
        if (result.list.count==0) {
            self.curentPage--;
        }else{
            [self.essenceData addObjectsFromArray:result.list];
        }
        
        [self.essenceTableView reloadData];
    } failure:^(NSError *error) {
        //发现两次请求不一样
        if (self.essenceParameter!= essenceParameter) return;
        self.curentPage--;
        [self.essenceTableView.mj_header endRefreshing];
        [self.essenceTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.essenceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSBaseCell *baseCell = [BSBaseCell baseCellForTableView:tableView indexPath:indexPath];
    baseCell.essenceListModel = self.essenceData[indexPath.row];
    baseCell.attendBtnClick = ^(BSEssenceListModel *essenceListModel){
        BSLog(@"关注->%@",essenceListModel.name);
    };
    baseCell.praiseBtnClick = ^(BSEssenceListModel *essenceListModel){
        BSLog(@"点赞->%@",essenceListModel.name);
    };
    baseCell.stampBtnClick = ^(BSEssenceListModel *essenceListModel){
        BSLog(@"踩->%@",essenceListModel.name);
    };
    baseCell.shareBtnClick = ^(BSEssenceListModel *essenceListModel){
        BSLog(@"转发->%@",essenceListModel.name);
    };
    baseCell.commentBtnClick = ^(BSEssenceListModel *essenceListModel){
        BSLog(@"评论->%@",essenceListModel.name);
    };
    //查看大图
    baseCell.seeBigPicBlock = ^(BSEssenceListModel *essenceListModel){
        BSShowBigPicViewController *showBigPicViewController = [BSShowBigPicViewController showBigPicViewController];
        showBigPicViewController.essenceListModel = essenceListModel;
        [self presentViewController:showBigPicViewController animated:NO completion:nil];
        BSLog(@"查看大图->%@",essenceListModel.name);
    };
    return baseCell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSEssenceListModel *essenceListModel = self.essenceData[indexPath.row];
    return essenceListModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}




@end
