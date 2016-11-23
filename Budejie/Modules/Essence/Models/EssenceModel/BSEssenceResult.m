//
//  BSEssenceResult.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceResult.h"
#import "BSInfoModel.h"
#import "BSEssenceListModel.h"

@implementation BSEssenceResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"info" : [BSInfoModel class]};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BSEssenceListModel class]};
}

@end
