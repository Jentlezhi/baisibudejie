//
//  BSCmtNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSCmtNetworkTool.h"
#import "BSNetworkTool.h"
#import "BSCmtDetailParameter.h"
#import "BSCmtDetailResult.h"

@implementation BSCmtNetworkTool

+ (NSURLSessionDataTask *)cmtWithParameters:(BSCmtDetailParameter *)parameters success:(void(^)(BSCmtDetailResult *result))success failure:(void(^)(NSError *error))failure{
    NSDictionary *pars = parameters.mj_keyValues;
    return [BSNetworkTool GET:kApiOpenUrl parameters:pars success:^(id responseObject) {
        if (success) {
            BSCmtDetailResult *result = [BSCmtDetailResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure && error.code != -999) {
            failure(error);
        }
    }];
}

@end
