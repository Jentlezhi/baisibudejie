//
//  BSLeftTagResultModel.m
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSLeftTagResultModel.h"
#import "BSLeftTagModel.h"

@implementation BSLeftTagResultModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BSLeftTagModel class]};
}

@end
