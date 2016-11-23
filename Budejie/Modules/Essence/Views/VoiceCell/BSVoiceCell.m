//
//  BSVoiceCell.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSVoiceCell.h"

@interface BSVoiceCell()

@end

@implementation BSVoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self voiceCellBasicConfig];
        [self initVoiceCellCellComponents];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)voiceCellBasicConfig{
    
}
/**
 *  初始化子控件
 */
- (void)initVoiceCellCellComponents{
    
}


+ (instancetype)voiceCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BSVoiceCellID";
    BSVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BSVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
