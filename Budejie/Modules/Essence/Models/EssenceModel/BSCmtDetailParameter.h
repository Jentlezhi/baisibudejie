//
//  BSCmtDetailParameter.h
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCmtDetailParameter : NSObject

/** dateList */
@property (nonatomic, copy) NSString *a;
/** comment */
@property (nonatomic, copy) NSString *c;
/** id */
@property (nonatomic, copy) NSString *data_id;
/** 热门评论 */
@property (nonatomic, copy) NSString *hot;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
/** 上次的id */
@property (nonatomic, copy) NSString *lastid;

@end
