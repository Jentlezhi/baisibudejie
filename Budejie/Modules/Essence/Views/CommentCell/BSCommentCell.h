//
//  BSCommentCell.h
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCommentModel;

@interface BSCommentCell : UITableViewCell

/** 评论数据模型 */
@property (nonatomic, strong) BSCommentModel *commentModel;

+ (instancetype)commentCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
