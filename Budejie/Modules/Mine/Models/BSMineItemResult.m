//
//  BSMineResult.m
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSMineItemResult.h"
#import "BSMineItemModel.h"

@implementation BSMineItemResult

+ (NSDictionary *)objectClassInArray{
    return @{@"square_list" : [BSMineItemModel class]};
}

@end
