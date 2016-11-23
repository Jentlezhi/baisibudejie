//
//  BSEssenceResult.h
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSInfoModel;
@interface BSEssenceResult : NSObject

/** 信息 */
@property (nonatomic, strong) BSInfoModel *info;
/** 列表 */
@property (nonatomic, strong) NSArray *list;

@end
