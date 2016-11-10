//
//  BSUserGroupResultModel.m
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSUserGroupResultModel.h"
#import "BSUserGroupModel.h"

@implementation BSUserGroupResultModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BSUserGroupModel class]};
}

@end
