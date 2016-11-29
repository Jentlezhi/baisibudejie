//
//  BSWebViewController.h
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BSWebViewController : BSBaseViewController

/** 标题 */
@property (nonatomic, copy) NSString *navTitle;
/** 链接 */
@property (nonatomic, copy) NSString *url;

@end
