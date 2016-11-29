//
//  BSMineItemNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSMineItemNetworkTool.h"
#import "BSNetworkTool.h"


@implementation BSMineItemNetworkTool

+ (NSURLSessionDataTask *)mineItemWithParameters:(BSMineParemeters *)parameters success:(void(^)(BSMineItemResult *result))success failure:(void(^)(NSError *error))failure{
    NSDictionary *pars = parameters.mj_keyValues;
    return [BSNetworkTool GET:kApiOpenUrl parameters:pars success:^(id responseObject) {
        if (success) {
            BSMineItemResult *result = [BSMineItemResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure && error.code != -999) {
            failure(error);
        }
    }];
}


@end
