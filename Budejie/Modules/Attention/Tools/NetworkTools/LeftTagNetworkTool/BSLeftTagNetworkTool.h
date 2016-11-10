//
//  BSLeftTagNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLeftTagResultModel.h"
#import "BSLeftTagParameter.h"

@interface BSLeftTagNetworkTool : NSObject

+ (NSURLSessionDataTask *)leftTagWithParameterss:(BSLeftTagParameter *)parameters success:(void(^)(BSLeftTagResultModel *result))success failure:(void(^)(NSError *error))failure;

@end
