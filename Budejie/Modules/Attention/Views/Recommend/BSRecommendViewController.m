//
//  BSRecommendViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSRecommendViewController.h"
#import "BSLeftTagNetworkTool.h"
#import "BSUserGroupNetworkTool.h"
#import "BSLeftTagCell.h"
#import "BSLeftTagModel.h"
#import "BSUserGroupModel.h"
#import "BSUserGroupCell.h"

#define BSLeftTagCellHeight   BSALayoutV(70)
#define BSUserGroupCellHeight BSALayoutV(100)
#define loadFrame CGRectMake(BSALayoutH(150), BSViewOriginY, kScreenWidth - BSALayoutH(150), BSViewHeight)

@interface BSRecommendViewController()<UITableViewDelegate,UITableViewDataSource>

/** 左侧标签列表 */
@property(strong, nonatomic) UITableView *leftTagTableView;
/** 左侧标签列表数据模型 */
@property(strong, nonatomic) NSArray *leftTagData;
/** 推荐用户组 */
@property(strong, nonatomic) UITableView *userGroupTableView;
/** 请求参数 */
@property(strong, nonatomic) BSUserGroupParameter *requestPar;

@end

@implementation BSRecommendViewController

+ (instancetype)recommendViewController{
    return [[self alloc] init];
}

- (UITableView *)leftTagTableView{
    if (!_leftTagTableView) {
        CGRect tableViewF = CGRectMake(0, BSViewOriginY,BSALayoutH(150),BSViewHeight);
        _leftTagTableView = [[UITableView alloc] initWithFrame:tableViewF];
        _leftTagTableView.backgroundColor = BSGlobalColor;
        _leftTagTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTagTableView.tableFooterView = [[UIView alloc] init];
        _leftTagTableView.dataSource = self;
        _leftTagTableView.delegate = self;
    }
    return _leftTagTableView;
}

- (NSArray *)leftTagData{
    if (!_leftTagData) {
        _leftTagData = [NSArray array];
    }
    return _leftTagData;
}

- (UITableView *)userGroupTableView{
    if (!_userGroupTableView) {
        _userGroupTableView = [[UITableView alloc] init];
        _userGroupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _userGroupTableView.tableFooterView = [[UIView alloc] init];
        _userGroupTableView.backgroundColor = BSGlobalColor;
        _userGroupTableView.delegate = self;
        _userGroupTableView.dataSource = self;
    }
    return _userGroupTableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self recommendBasicConfig];
    [self recommendInitComponents];
    [self requestLeftTag];
    [self refreshUserList];
}
/**
 *  基本配置
 */
- (void)recommendBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"推荐关注"];
}

/**
 *  初始化子控件
 */
- (void)recommendInitComponents{
    //添加左侧标签列表
    [self.view addSubview:self.leftTagTableView];
    //添加右侧推荐用户列表
    [self.view addSubview:self.userGroupTableView];
    [_userGroupTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTagTableView.mas_right);
        make.top.equalTo(self.view).offset(BSViewOriginY);
        make.right.bottom.equalTo(self.view);
    }];
}

/**
 *  获取左侧标签的列表
 */
- (void)requestLeftTag{
    BSLeftTagParameter *leftTagParameter = [BSLeftTagParameter leftTagParameter];
    leftTagParameter.a = @"category";
    leftTagParameter.c = @"subscribe";
    [MBProgressHUD showInView:self.view withMessage:@"正在加载..."];
    self.sessionDateTask = [BSLeftTagNetworkTool leftTagWithParameterss:leftTagParameter success:^(BSLeftTagResultModel *result) {
        [MBProgressHUD hidden];
        self.leftTagData = result.list;
        [self.leftTagTableView reloadData];
        [self.leftTagTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //刷新第一个标签对应的表格
        [self.userGroupTableView.mj_header beginRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hidden];
        [MBProgressHUD showErrorWithMessage:@"加载数据失败"];
    }];
}

/**
 *  获取右侧推荐用户的列表
 */
- (void)requestUserGroupListWithLeftTagModel:(BSLeftTagModel *)leftTagModel page:(int)page{
    BSUserGroupParameter *userGroupParameter = [BSUserGroupParameter userGroupParameter];
    userGroupParameter.a = @"list";
    userGroupParameter.c = @"subscribe";
    userGroupParameter.category_id = leftTagModel.ID;
    userGroupParameter.page = page;
    //记录本次的请求参数
    self.requestPar = userGroupParameter;
    self.sessionDateTask = [BSUserGroupNetworkTool userGroupWithParameterss:userGroupParameter success:^(BSUserGroupResultModel *result) {
        //如果两次请求参数不一样则取消请求
        if (self.requestPar != userGroupParameter)return;
        [self.userGroupTableView.mj_header endRefreshing];
        //记录下次请求的页码
        leftTagModel.userListNextPage = result.next_page;
        if (result.list.count) {
            if (leftTagModel.userList.count && page== 1) {
                [leftTagModel.userList removeAllObjects];
            }
            [leftTagModel.userList addObjectsFromArray:result.list];
        }
        if (leftTagModel.userList.count == result.total) {
            [self.userGroupTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userGroupTableView.mj_footer endRefreshing];
        }
        [self.userGroupTableView reloadData];
    } failure:^(NSError *error) {
        if (self.requestPar != userGroupParameter)return;
        [self.userGroupTableView.mj_header endRefreshing];
        [self.userGroupTableView.mj_footer endRefreshing];
        [MBProgressHUD showErrorWithMessage:@"加载数据失败"];
    }];
}

- (void)refreshUserList{   
    __weak typeof(self) weakSelf = self;
    //加载更多
    self.userGroupTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        BSLeftTagModel *leftTagModel = weakSelf.leftTagData[weakSelf.leftTagTableView.indexPathForSelectedRow.row];
        [weakSelf requestUserGroupListWithLeftTagModel:leftTagModel page:leftTagModel.userListNextPage];
    }];
    
    //刷新数据
    self.userGroupTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        BSLeftTagModel *leftTagModel = weakSelf.leftTagData[weakSelf.leftTagTableView.indexPathForSelectedRow.row];
        [weakSelf requestUserGroupListWithLeftTagModel:leftTagModel page:1];
    }];
}



#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTagTableView) {
        return self.leftTagData.count;
    }else{
        if (self.leftTagData.count) {
            BSLeftTagModel *leftTagModel = self.leftTagData[self.leftTagTableView.indexPathForSelectedRow.row];
            return leftTagModel.userList.count;
        }
        return 0;

    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTagTableView) {
        BSLeftTagCell *cell = [BSLeftTagCell leftTagCellForTableView:tableView indexPath:indexPath];
        cell.leftTagModel = self.leftTagData[indexPath.row];
        return cell;
    }else{
        BSUserGroupCell *cell = [BSUserGroupCell userGroupCellForTableView:tableView indexPath:indexPath];
        BSLeftTagModel *leftTagModel = self.leftTagData[self.leftTagTableView.indexPathForSelectedRow.row];
        cell.userGroupModel = leftTagModel.userList[indexPath.row];
        cell.acctionBtnClick = ^(BSUserGroupModel *userGroupModel){
            BSLogBlue(@"%@",userGroupModel.screen_name);
        };
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTagTableView) {
        return BSLeftTagCellHeight;
    }
    return BSUserGroupCellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //结束刷新
    [self.userGroupTableView.mj_header endRefreshing];
    [self.userGroupTableView.mj_footer endRefreshing];
    
    if (tableView == self.leftTagTableView) {
        BSLeftTagModel *leftTagModel = self.leftTagData[indexPath.row];
        if (leftTagModel.userList.count) {
            [self.userGroupTableView reloadData];
        }else{
            [self.userGroupTableView reloadData];
            [self.userGroupTableView.mj_header beginRefreshing];
        }
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


@end
