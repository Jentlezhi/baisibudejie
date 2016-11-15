//
//  BSUserGroupCell.h
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSUserGroupModel;

@interface BSUserGroupCell : UITableViewCell

/** 左侧标签 */
@property(strong, nonatomic) BSUserGroupModel *userGroupModel;

/** 关注按钮的点击 */
@property(copy, nonatomic) void(^acctionBtnClick)(BSUserGroupModel *);

+ (instancetype)userGroupCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
