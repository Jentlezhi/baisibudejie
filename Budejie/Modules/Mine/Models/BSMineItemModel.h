//
//  BSMineItemModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSMineItemModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *icon;
/** 标题文字 */
@property (nonatomic, copy) NSString *name;
/** 链接 */
@property (nonatomic, copy) NSString *url;

@end
