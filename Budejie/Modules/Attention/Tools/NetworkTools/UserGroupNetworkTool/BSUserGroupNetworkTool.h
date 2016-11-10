//
//  BSUserGroupNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/10.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNetworkTool.h"
#import "BSUserGroupResultModel.h"
#import "BSUserGroupParameter.h"

@interface BSUserGroupNetworkTool : NSObject

+ (NSURLSessionDataTask *)userGroupWithParameterss:(BSUserGroupParameter *)parameters success:(void(^)(BSUserGroupResultModel *result))success failure:(void(^)(NSError *error))failure;

@end
