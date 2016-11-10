//
//  BSUserGroupParameter.h
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUserGroupParameter : NSObject

/** list */
@property(copy, nonatomic) NSString *a;
/** subscribe */
@property(copy, nonatomic) NSString *c;
/** 要查询的推荐标签的id（和“推荐关注”页面中左侧关注标签API返回值中的id参数对应) */
@property(copy, nonatomic) NSString *category_id;
/** 页码数，默认为1 */
@property(assign, nonatomic) int page;

+ (instancetype)userGroupParameter;

@end
