//
//  BSEssenceNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSEssenceNetworkTool.h"
#import "BSNetworkTool.h"

@implementation BSEssenceNetworkTool
+ (NSURLSessionDataTask *)essenceWithParameters:(BSEssenceParameter *)parameters success:(void(^)(BSEssenceResult *result))success failure:(void(^)(NSError *error))failure{
    NSDictionary *pars = parameters.mj_keyValues;
    return [BSNetworkTool GET:kApiOpenUrl parameters:pars success:^(id responseObject) {
        if (success) {
            BSEssenceResult *result = [BSEssenceResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
