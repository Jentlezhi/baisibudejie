//
//  BSAllViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/17.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSAllViewController.h"
#import "BSEssenceListModel.h"
#import "BSAllCell.h"

@interface BSAllViewController ()

@end

@implementation BSAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allInitComponents];
}
/**
 *  初始化子控件
 */
- (void)allInitComponents{

}



#pragma mark - <UITableViewDataSource>

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSAllCell *allCell = [BSAllCell allCellForTableView:tableView indexPath:indexPath];
//    allCell.essenceListModel = self.essenceData[indexPath.row];
//    allCell.attendBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"关注->%@",essenceListModel.name);
//    };
//    allCell.praiseBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"点赞->%@",essenceListModel.name);
//    };
//    allCell.stampBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"踩->%@",essenceListModel.name);
//    };
//    allCell.shareBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"转发->%@",essenceListModel.name);
//    };
//    allCell.commentBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"评论->%@",essenceListModel.name);
//    };
//    return allCell;
//}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end

