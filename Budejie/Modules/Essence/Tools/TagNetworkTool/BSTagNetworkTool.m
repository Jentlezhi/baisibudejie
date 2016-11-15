//
//  BSTagNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSTagNetworkTool.h"

@implementation BSTagNetworkTool

+ (NSURLSessionDataTask *)tagWithParameters:(BSTagParameter *)parameters success:(void(^)(id result))success failure:(void(^)(NSError *error))failure{
    NSDictionary *pars = parameters.mj_keyValues;
    return [BSNetworkTool GET:kApiOpenUrl parameters:pars success:^(id responseObject) {
        if (success) {
            NSArray *result = [BSTagModel mj_objectArrayWithKeyValuesArray:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
