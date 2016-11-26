//
//  BSCmtSectionHeader.h
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCmtSectionHeader : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic, copy) NSString *sectionTitle;

+ (instancetype)cmtSectionHeaderWithTableView:(UITableView *)tableView;

@end
