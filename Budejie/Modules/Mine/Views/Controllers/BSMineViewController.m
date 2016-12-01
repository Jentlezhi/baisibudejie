//
//  BSMineViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSMineViewController.h"
#import "BSMineCell.h"
#import "BSMineItemNetworkTool.h"
#import "BSMineFooterView.h"
#import "BSLoginRegisterViewController.h"

@interface BSMineViewController()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/** 列表 */
@property(strong, nonatomic) UITableView *mineTableView;
/** footer */
@property(strong, nonatomic) BSMineFooterView *mineFooterView;

@end

@implementation BSMineViewController

- (UITableView *)mineTableView{
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mineTableView.backgroundColor = BSGlobalColor;
        _mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mineTableView.dataSource = self;
        _mineTableView.delegate = self;
        _mineTableView.sectionHeaderHeight = 0.f;
        _mineTableView.sectionFooterHeight = BSEssenceCellMargin;
        _mineTableView.contentInset = UIEdgeInsetsMake(BSEssenceCellMargin-35 + BSViewOriginY, 0, BSTabBarHeight, 0);
    }
    return _mineTableView;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self mineBasicConfig];
    [self mineInitComponents];
    [self refreshMineData];
    [self requestMineData];
}

/**
 *  基本配置
 */
- (void)mineBasicConfig{
    [self createNavBarWithTitle:@"我的"];
}
/**
 *  初始化子控件
 */
- (void)mineInitComponents{
    
    //设置按钮
    UIButton *settingBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"]];
    CGFloat settingBtnW = settingBtn.currentBackgroundImage.size.width;
    CGFloat settingBtnH = settingBtn.currentBackgroundImage.size.height;
    CGFloat settingBtnX = self.navigationBar.width-settingBtnW-BSMarigin;
    CGFloat settingBtnY = (self.navigationBar.height-settingBtnH)*0.5;
    settingBtn.frame = CGRectMake(settingBtnX , settingBtnY, settingBtnW, settingBtnH);
    [[settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSLogCyan(@"%s",__func__);
    }];
    [self.navigationBar addSubview:settingBtn];
    
    //夜间模式按钮
    UIButton *nightBtn = [UIButton buttonWithBackgroundNormalImage:[UIImage imageNamed:@"mine-moon-icon"] highlightImage:[UIImage imageNamed:@"mine-moon-icon-click"]];
    CGFloat nightBtnW = settingBtn.currentBackgroundImage.size.width;
    CGFloat nightBtnH = settingBtn.currentBackgroundImage.size.height;
    CGFloat nightBtnX = self.navigationBar.width-settingBtnW-nightBtnW-2*BSMarigin;
    CGFloat nightBtnY = (self.navigationBar.height-settingBtnH)*0.5;
    nightBtn.frame = CGRectMake(nightBtnX , nightBtnY, nightBtnW, nightBtnH);
    [[nightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        BSLogCyan(@"%s",__func__);
    }];
    [self.navigationBar addSubview:nightBtn];
    
    //添加列表
    [self.view insertSubview:self.mineTableView belowSubview:self.navigationZone];
    [self.mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
    
    //创建footerView
    self.mineFooterView = [[BSMineFooterView alloc] init];
    
    
}

/**
 * 刷新数据
 */
- (void)refreshMineData{
    __weak typeof(self) weakSelf = self;
    //刷新数据
    self.mineTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestMineData];
    }];
    self.mineTableView.mj_header.automaticallyChangeAlpha = YES;
}


- (void)requestMineData{
    CGFloat margin = BSEssenceCellMargin;
    NSUInteger maxCols = 4;
    CGFloat itemBtnH = (kScreenWidth - 2*margin)/maxCols;
    
    BSMineParemeters *mineParemeters = [[BSMineParemeters alloc] init];
    mineParemeters.a = @"square";
    mineParemeters.c = @"topic";
    self.sessionDateTask = [BSMineItemNetworkTool mineItemWithParameters:mineParemeters success:^(BSMineItemResult *result) {
        [self.mineTableView.mj_header endRefreshing];
        self.mineFooterView.mineItems = result.square_list;
        NSUInteger rows = (result.square_list.count + maxCols - 1) / maxCols;
        self.mineFooterView.height = rows*itemBtnH;
        self.mineTableView.tableFooterView = self.mineFooterView;
    } failure:^(NSError *error) {
        self.mineTableView.tableFooterView = self.mineFooterView;
        self.mineFooterView.mineItems = [NSArray array];
        [self.mineTableView.mj_header endRefreshing];
    }];

}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BSMineCell *cell = [BSMineCell mineCellForTableView:tableView indexPath:indexPath];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {//注册登录
        BSLoginRegisterViewController *logVC = [[BSLoginRegisterViewController alloc] init];
        [self presentViewController:logVC animated:YES completion:nil];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self cancelRequest];
}

- (void)dealloc{
    [self cancelRequest];
}
@end
