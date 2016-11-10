//
//  BSLeftTagCell.h
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSLeftTagModel;

@interface BSLeftTagCell : UITableViewCell

/** 左侧标签 */
@property(strong, nonatomic) BSLeftTagModel *leftTagModel;

+ (instancetype)leftTagCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
