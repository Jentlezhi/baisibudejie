//
//  BSEssenceParameter.h
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSEssenceParameter : NSObject

/** 参数值为list，如果想要获取“新帖”板块的帖子，则传入"newlist"即可 */
@property(copy, nonatomic) NSString *a;
/** data */
@property(copy, nonatomic) NSString *c;
/** 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容 */
@property(copy, nonatomic) NSString *maxtime;
/** 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1 */
@property (assign, nonatomic) int type;
/** 页码 */
@property (assign, nonatomic) NSInteger page;

+ (instancetype)essenceParameter;

@end
