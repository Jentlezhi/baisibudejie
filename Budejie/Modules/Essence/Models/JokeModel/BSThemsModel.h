//
//  BSThemsModel.h
//  Budejie
//
//  Created by Jentle on 2016/11/17.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSThemsModel : NSObject

/** 主题id */
@property (nonatomic, copy) NSString *theme_id;
/** 主题类型 */
@property (nonatomic, copy) NSString *theme_type;
/** 主题名称 */
@property (nonatomic, copy) NSString *theme_name;

@end
