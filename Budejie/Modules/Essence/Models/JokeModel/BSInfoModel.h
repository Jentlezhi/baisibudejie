//
//  BSInfoModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/17.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSInfoModel : NSObject

/** 帖子的总数 */
@property (nonatomic, assign) NSInteger count;
/** 默认情况下，就是一页20个帖子情况下的最大页数 */
@property (nonatomic, assign) NSInteger page;
/** 最大的帖子id */
@property (nonatomic, copy) NSString *maxid;
/** 每次加载下一页的时候，需要传入上一页返回参数中对应的此内容，例如：1434112682 */
@property (nonatomic, copy) NSString *maxtime;


@end
