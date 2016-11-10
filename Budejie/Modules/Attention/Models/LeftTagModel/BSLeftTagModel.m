//
//  BSLeftTagModel.m
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSLeftTagModel.h"

@implementation BSLeftTagModel

- (NSMutableArray *)userList{
    if (!_userList) {
        _userList = [NSMutableArray array];
    }
    return _userList;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID" : @"id"};
}

@end
