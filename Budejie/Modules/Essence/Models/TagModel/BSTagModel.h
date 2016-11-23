//
//  BSagModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTagModel : NSObject

/** 是否含有子标签 */
@property(copy, nonatomic) NSString *is_sub;
/** 此标签的id */
@property(copy, nonatomic) NSString *theme_id;
/** 推荐标签的图片url地址 */
@property(copy, nonatomic) NSString *image_list;
/** 标签名称 */
@property (copy, nonatomic) NSString *theme_name;
/** 此标签的订阅量 */
@property (copy, nonatomic) NSString *sub_number;
/** 是否是默认的推荐标签 */
@property(assign, nonatomic) int is_default;

@end
