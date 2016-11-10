//
//  BSUserGroupResultModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUserGroupResultModel : NSObject

/** 用户列表 */
@property(strong, nonatomic) NSArray *list;
/** 总数 */
@property(assign, nonatomic) int total;
/** 当前页码 */
@property(assign, nonatomic) int next_page;

@end
