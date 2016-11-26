//
//  BSTagViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTagViewController.h"
#import "BSTagNetworkTool.h"
#import "BSTagModel.h"
#import "BSTagCell.h"

#define BSTagCellHeight   BSALayoutV(120)

@interface BSTagViewController()<UITableViewDelegate,UITableViewDataSource>

/** 推荐标签列表 */
@property(strong, nonatomic) UITableView *tagTableView;
/** 推荐标签数据模型 */
@property(strong, nonatomic) NSArray *tagData;

@end

@implementation BSTagViewController

- (NSArray *)tagData{
    if (!_tagData) {
        _tagData = [NSArray array];
    }
    return _tagData;
}

- (UITableView *)tagTableView{
    if (!_tagTableView) {
        _tagTableView = [[UITableView alloc] init];
        _tagTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tagTableView.tableFooterView = [[UIView alloc] init];
        _tagTableView.delegate = self;
        _tagTableView.dataSource = self;
    }
    return _tagTableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self tagBasicConfig];
    [self initTagComponents];
    [self requestTagList];
}
/**
 *  基本配置
 */
- (void)tagBasicConfig{
     [self createNavBarWithBackButtonAndTitle:@"推荐标签"];
}

/**
 *  初始化子控件
 */
- (void)initTagComponents{
    //添加标签列表
    [self.view addSubview:self.tagTableView];
    [self.tagTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(BSViewOriginY);
    }];
}

/**
 *  请求数据
 */
- (void)requestTagList{
    BSTagParameter *tagParameter = [BSTagParameter tagParameter];
    tagParameter.a = @"tag_recommend";
    tagParameter.action = @"sub";
    tagParameter.c = @"topic";
    [MBProgressHUD showInView:self.view withMessage:@"正在加载..."];
    self.sessionDateTask = [BSTagNetworkTool tagWithParameters:tagParameter success:^(id result) {
        [MBProgressHUD hidden];
        self.tagData = result;
        [self.tagTableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hidden];
        [MBProgressHUD showErrorWithMessage:@"加载数据失败"];
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tagData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSTagCell *cell = [BSTagCell tagCellForTableView:tableView indexPath:indexPath];
    cell.tagModel = self.tagData[indexPath.row];
    cell.acctionBtnClick = ^(BSTagModel *tagModel){
        BSLogRed(@"%@",tagModel.theme_name);
    };
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSTagCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self cancelRequest];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self cancelRequest];
}



@end
