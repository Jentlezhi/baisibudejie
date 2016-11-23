//
//  BSBaseCell.h
//  Budejie
//
//  Created by Jentle on 2016/11/18.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSEssenceListModel;

@interface BSBaseCell : UITableViewCell

/** 数据模型 */
@property(strong, nonatomic) BSEssenceListModel *essenceListModel;

/** 关注 按钮的点击 */
@property(copy, nonatomic) void(^attendBtnClick)(id);
/** 点赞 按钮的点击 */
@property(copy, nonatomic) void(^praiseBtnClick)(id);
/** 踩 按钮的点击 */
@property(copy, nonatomic) void(^stampBtnClick)(id);
/** 分享 按钮的点击 */
@property(copy, nonatomic) void(^shareBtnClick)(id);
/** 评论 按钮的点击 */
@property(copy, nonatomic) void(^commentBtnClick)(id);
/** 查看大图 */
@property(copy, nonatomic) void(^seeBigPicBlock)(id);
/** 播放音频 */
@property(copy, nonatomic) void(^voicePlayBlock)(id);
/** 播放视频 */
@property(copy, nonatomic) void(^videoPlayBlock)(id);

/**
 * 工具条按钮设置
 */
- (void)setToolBarButtonTitle:(UIButton *)btn count:(NSInteger)count;

+ (instancetype)baseCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
