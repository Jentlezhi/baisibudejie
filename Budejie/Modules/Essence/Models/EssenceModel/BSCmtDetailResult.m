//
//  BSCmtDetailResult.m
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSCmtDetailResult.h"
#import "BSCommentModel.h"

@implementation BSCmtDetailResult


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [BSCommentModel class],
             @"hot"  : [BSCommentModel class]};
}

@end
