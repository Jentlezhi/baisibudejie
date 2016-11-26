//
//  BSCmtNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/25.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSCmtDetailParameter.h"
#import "BSCmtDetailResult.h"

@interface BSCmtNetworkTool : NSObject

+ (NSURLSessionDataTask *)cmtWithParameters:(BSCmtDetailParameter *)parameters success:(void(^)(BSCmtDetailResult *result))success failure:(void(^)(NSError *error))failure;

@end
