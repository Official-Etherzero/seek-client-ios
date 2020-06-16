//
//  AFHTTPSessionManager+Ext.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/7.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (Ext)

+ (AFHTTPSessionManager *)yy_manager;

- (NSURLSessionDataTask *)yy_POST_FORM:(NSString *)URLString
                            parameters:(id)parameters
             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       completeHandler:(void (^)(NSURLSessionDataTask *task,id responseObject, NSError *error))completeHandler;

- (NSURLSessionDataTask *)yy_noCacheGET:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask * , id ))success
                                failure:(void (^)(NSURLSessionDataTask * , NSError * ))failure;

- (NSURLSessionDataTask *)yy_noCacheGET:(NSString *)URLString
                             parameters:(id)parameters
                        completeHandler:(void (^)(NSURLSessionDataTask * ,id  responseObject, NSError *))completeHandler;

- (NSURLSessionDataTask *)yy_syncPOST:(NSString *)URLString
                           parameters:(id)parameters
            constructingBodyWithBlock:(void (^)( id <AFMultipartFormData> formData))block
                             progress:(void (^)(NSProgress * ))uploadProgress
                              success:(void (^)(NSURLSessionDataTask * task,  id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

@end

NS_ASSUME_NONNULL_END
