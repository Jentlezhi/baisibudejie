//
//  BSVideoCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSVideoCell.h"

@interface BSVideoCell()

@end

@implementation BSVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self videoCellBasicConfig];
        [self initVideoCellCellComponents];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)videoCellBasicConfig{
    
}
/**
 *  初始化子控件
 */
- (void)initVideoCellCellComponents{
    
}


+ (instancetype)videoCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSVideoCellID";
    BSVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
