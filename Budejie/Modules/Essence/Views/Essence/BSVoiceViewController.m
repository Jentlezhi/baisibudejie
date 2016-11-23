//
//  BSVoiceViewController.m
//  Budejie
//
//  Created by Jentle on 2016/11/17.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSVoiceViewController.h"
#import "BSEssenceListModel.h"
#import "BSVoiceCell.h"

@interface BSVoiceViewController ()

@end

@implementation BSVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self voiceInitComponents];
}
/**
 *  初始化子控件
 */
- (void)voiceInitComponents{
}

//#pragma mark - <UITableViewDataSource>
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSVoiceCell *voiceCell = [BSVoiceCell voiceCellForTableView:tableView indexPath:indexPath];
//    voiceCell.essenceListModel = self.essenceData[indexPath.row];
//    voiceCell.attendBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"关注->%@",essenceListModel.name);
//    };
//    voiceCell.praiseBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"点赞->%@",essenceListModel.name);
//    };
//    voiceCell.stampBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"踩->%@",essenceListModel.name);
//    };
//    voiceCell.shareBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"转发->%@",essenceListModel.name);
//    };
//    voiceCell.commentBtnClick = ^(BSEssenceListModel *essenceListModel){
//        BSLog(@"评论->%@",essenceListModel.name);
//    };
//    return voiceCell;
//}
//
//#pragma mark - <UITableViewDelegate>
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//}

@end
