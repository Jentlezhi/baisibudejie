//
//  BSPictureCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSPictureCell.h"


@interface BSPictureCell()

@end

@implementation BSPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self pictureCellBasicConfig];
        [self initPictureCellCellComponents];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)pictureCellBasicConfig{
    
}
/**
 *  初始化子控件
 */
- (void)initPictureCellCellComponents{
    
}


+ (instancetype)pictureCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSJokeCellID";
    BSPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
