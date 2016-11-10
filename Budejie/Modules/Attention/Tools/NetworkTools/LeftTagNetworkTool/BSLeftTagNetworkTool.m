//
//  BSLeftTagNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSLeftTagNetworkTool.h"
#import "BSNetworkTool.h"
#import "BSLeftTagResultModel.h"
#import "BSLeftTagParameter.h"

@implementation BSLeftTagNetworkTool

+ (NSURLSessionDataTask *)leftTagWithParameterss:(BSLeftTagParameter *)parameters success:(void(^)(BSLeftTagResultModel *result))success failure:(void(^)(NSError *error))failure{
    NSDictionary *pars = parameters.mj_keyValues;
   return [BSNetworkTool GET:kApiOpenUrl parameters:pars success:^(id responseObject) {
        if (success) {
            BSLeftTagResultModel *result = [BSLeftTagResultModel mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
