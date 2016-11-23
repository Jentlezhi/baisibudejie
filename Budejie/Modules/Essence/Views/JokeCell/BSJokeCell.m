//
//  BSJokeCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/18.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSJokeCell.h"
#import "BSEssenceListModel.h"

@interface BSJokeCell()

@end

@implementation BSJokeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jokeCellBasicConfig];
        [self initJokeCellCellComponents];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)jokeCellBasicConfig{
    
}
/**
 *  初始化子控件
 */
- (void)initJokeCellCellComponents{
    
}


+ (instancetype)jokeCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSJokeCellID";
    BSJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSJokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}






@end
