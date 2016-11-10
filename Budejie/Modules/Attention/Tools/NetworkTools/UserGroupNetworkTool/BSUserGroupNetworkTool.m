//
//  BSUserGroupNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSUserGroupNetworkTool.h"

@implementation BSUserGroupNetworkTool

+ (NSURLSessionDataTask *)userGroupWithParameterss:(BSUserGroupParameter *)parameters success:(void(^)(BSUserGroupResultModel *result))success failure:(void(^)(NSError *error))failure{
    NSDictionary *pars = parameters.mj_keyValues;
    return [BSNetworkTool GET:kApiOpenUrl parameters:pars success:^(id responseObject) {
        if (success) {
            BSUserGroupResultModel *result = [BSUserGroupResultModel mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
