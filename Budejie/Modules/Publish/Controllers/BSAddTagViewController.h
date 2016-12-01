//
//  BSAddTagViewController.h
//  Budejie
//
//  Created by Jentle on 2016/11/30.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSBaseViewController.h"

@interface BSAddTagViewController : BSBaseViewController

@property (strong, nonatomic) NSArray *tagTitles;
@property (copy, nonatomic) void(^finishEditTag)(NSArray *);

@end
