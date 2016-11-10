//
//  BSLeftTagModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSLeftTagModel : NSObject

/** 标签id */
@property(copy, nonatomic) NSString *ID;
/** 标签名称 */
@property(copy, nonatomic) NSString *name;
/** 此标签下的用户数 */
@property(copy, nonatomic) NSString *count;
/** 这个id对应的用户列表 */
@property(strong, nonatomic) NSMutableArray *userList;
/** 用户列表当前页面 */
@property(assign, nonatomic) int userListNextPage;


@end
