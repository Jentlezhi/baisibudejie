//
//  BSLeftTagResultModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSLeftTagResultModel : NSObject

/** 左侧标签总数 */
@property(assign, nonatomic) int total;
/** 标签数组*/
@property(strong, nonatomic) NSArray *list;

@end
