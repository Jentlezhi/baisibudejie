//
//  BSTagNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/11.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNetworkTool.h"
#import "BSTagParameter.h"
#import "BSTagModel.h"

@interface BSTagNetworkTool : NSObject

+ (NSURLSessionDataTask *)tagWithParameters:(BSTagParameter *)parameters success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

@end
