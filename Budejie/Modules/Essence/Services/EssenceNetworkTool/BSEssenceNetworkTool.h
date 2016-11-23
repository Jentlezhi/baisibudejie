//
//  BSEssenceNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/20.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSEssenceParameter.h"
#import "BSEssenceResult.h"

@interface BSEssenceNetworkTool : NSObject

+ (NSURLSessionDataTask *)essenceWithParameters:(BSEssenceParameter *)parameters success:(void(^)(BSEssenceResult *result))success failure:(void(^)(NSError *error))failure;

@end
