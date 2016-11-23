//
//  BSEssenceBaseViewController.h
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BSEssenceBaseViewController : BSBaseViewController

/** 类型 */
@property(assign,nonatomic)BSTopicType type;

+ (instancetype)essenceBaseViewController;

@end
