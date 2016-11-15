//
//  BSTagCell.h
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTagModel;

@interface BSTagCell : UITableViewCell

/** 标签模型 */
@property(strong, nonatomic) BSTagModel *tagModel;

/** 关注按钮的点击 */
@property(copy, nonatomic) void(^acctionBtnClick)(BSTagModel *);

+ (instancetype)tagCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
