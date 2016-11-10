//
//  BSUserGroupModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUserGroupModel : NSObject

/** 推荐的用户id */
@property(copy, nonatomic) NSString *uid;
/** 所推荐的用户昵称 */
@property(copy, nonatomic) NSString *screen_name;
/** 用户描述 */
@property(copy, nonatomic) NSString *introduction;
/** 所推荐用户的被关注量 */
@property(copy, nonatomic) NSString *fans_count;
/** 所发表的贴子数量 */
@property(assign, nonatomic) int tiezi_count;
/** 所推荐的用户的头像url */
@property(copy, nonatomic) NSString *header;
/** 性别,0为男，1为女 */
@property(assign, nonatomic) int gender;
/** 是否是我关注的用户 */
@property(assign, nonatomic) int is_follow;

@end
