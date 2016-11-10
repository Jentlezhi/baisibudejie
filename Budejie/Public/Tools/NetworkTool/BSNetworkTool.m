//
//  BSNetworkTool.m
//  Budejie
//
//  Created by Jentle on 2016/11/9.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "BSNetworkTool.h"

#define kNetworkActivityIndicatorVisible [UIApplication sharedApplication].networkActivityIndicatorVisible
#define kTimeoutInterval 10.f

@implementation BSNetworkTool

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject) )success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = kTimeoutInterval;
    kNetworkActivityIndicatorVisible = YES;
   return [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        kNetworkActivityIndicatorVisible = NO;
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            kNetworkActivityIndicatorVisible = NO;
            failure(error);
        }
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject) )success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = kTimeoutInterval;
    kNetworkActivityIndicatorVisible = YES;
   return [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        kNetworkActivityIndicatorVisible = NO;
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        kNetworkActivityIndicatorVisible = NO;
        if (failure) {
            failure(error);
        }
    }];

}


@end
