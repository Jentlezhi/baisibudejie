//
//  BSAllCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSAllCell.h"

@interface BSAllCell()

@end

@implementation BSAllCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allCellBasicConfig];
        [self initAllCellCellComponents];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)allCellBasicConfig{
    
}
/**
 *  初始化子控件
 */
- (void)initAllCellCellComponents{
    
}


+ (instancetype)allCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSAllCellID";
    BSAllCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSAllCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
