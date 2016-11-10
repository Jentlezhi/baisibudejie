//
//  BSNetworkTool.h
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSNetworkTool : NSObject

/**
 *  GET请求
 *
 *  @param url        请求路径
 *  @param parameters 请求参数
 *  @param success    请求成功
 *  @param failure    请求失败
 */
+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject) )success failure:(void (^)(NSError *error))failure;
/**
 *  POST请求
 *
 *  @param url        请求路径
 *  @param parameters 请求参数
 *  @param success    请求成功
 *  @param failure    请求失败
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject) )success failure:(void (^)(NSError *error))failure;

@end
