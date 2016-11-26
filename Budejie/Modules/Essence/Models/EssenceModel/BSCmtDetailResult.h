//
//  BSCmtDetailResult.h
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCmtDetailResult : NSObject

/** 总数 */
@property (nonatomic, copy) NSString *total;
/** 数据 */
@property (nonatomic, strong) NSArray *data;
/** 热门 */
@property (nonatomic, copy) NSArray *hot;
/** author */
@property (nonatomic, copy) NSString *author;

@end
