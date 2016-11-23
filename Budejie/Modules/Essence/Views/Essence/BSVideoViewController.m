//
//  BSVideoViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/17.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSVideoViewController.h"
#import "BSEssenceListModel.h"
#import "BSVideoCell.h"

@interface BSVideoViewController ()

@end

@implementation BSVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self videoInitComponents];
}
/**
 *  初始化子控件
 */
- (void)videoInitComponents{
}


//#pragma mark - <UITableViewDataSource>
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSVideoCell *videoCell = [BSVideoCell videoCellForTableView:tableView indexPath:indexPath];
//    videoCell.essenceListModel = self.essenceData[indexPath.row];
//    videoCell.attendBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"关注->%@",essenceListModel.name);
//    };
//    videoCell.praiseBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"点赞->%@",essenceListModel.name);
//    };
//    videoCell.stampBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"踩->%@",essenceListModel.name);
//    };
//    videoCell.shareBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"转发->%@",essenceListModel.name);
//    };
//    videoCell.commentBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"评论->%@",essenceListModel.name);
//    };
//    return videoCell;
//}
//
//#pragma mark - <UITableViewDelegate>
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//}

@end
