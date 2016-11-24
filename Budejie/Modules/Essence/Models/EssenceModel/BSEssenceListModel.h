//
//  BSEssenceListModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSEssenceListModel : NSObject

/** 帖子id */
@property (nonatomic, assign) int ID;
/** 用户id */
@property (nonatomic, copy) NSString *user_id;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 头像的图片url地址 */
@property (nonatomic, copy) NSString *profile_image;
/** 是否是新浪会员 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 是否是百思不得姐的认证用户 */
@property (nonatomic, assign, getter=isJie_v) BOOL jie_v;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 主题 */
@property (nonatomic, strong) NSArray *themes;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) BSTopicType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 最热评论(数组中是Comment模型) */
@property (nonatomic, strong) NSArray *top_cmt;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** pic的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;
/** voice的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;
/** 最热评论的frame */
@property (nonatomic, assign, readonly) CGRect topCmtF;
/** 是否为大图 */
@property (nonatomic, assign, getter=isBigPic) BOOL bigPic;
/** 是否为gif图 */
@property (nonatomic, assign, getter=isGifPic) BOOL gifPic;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat picProgressValue;



@end
