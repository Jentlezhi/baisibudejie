//
//  BSCommentModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/24.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSUserModel;

@interface BSCommentModel : NSObject

/** 帖子id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) BSUserModel *user;


///** cell的高度 */
//@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
