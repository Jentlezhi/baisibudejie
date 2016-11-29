//
//  BSMineItemNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSMineParemeters.h"
#import "BSMineItemResult.h"

@interface BSMineItemNetworkTool : NSObject

+ (NSURLSessionDataTask *)mineItemWithParameters:(BSMineParemeters *)parameters success:(void(^)(BSMineItemResult *result))success failure:(void(^)(NSError *error))failure;

@end
