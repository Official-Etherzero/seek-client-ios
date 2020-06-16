//
//  AFHTTPSessionManager+Ext.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/7.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "AFHTTPSessionManager+Ext.h"

@implementation AFHTTPSessionManager (Ext)

+ (AFHTTPSessionManager *)yy_manager {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager * manager;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES；
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
    });
    
    return manager;
}

- (NSURLSessionDataTask *)yy_POST_FORM:(NSString *)URLString
                             parameters:( id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                        completeHandler:(void (^)(NSURLSessionDataTask *task,id responseObject, NSError *error))completeHandler {
    return [self POST:URLString
           parameters:parameters
constructingBodyWithBlock:block
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  completeHandler(task,responseObject, nil);
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  completeHandler(task,nil, error);
              }];
}

- (NSURLSessionDataTask *)yy_noCacheGET:(NSString *)URLString
                              parameters:(id)parameters
                                 success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                 failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self GET:URLString
          parameters:parameters
            progress:nil
             success:success
             failure:failure];
}


- (NSURLSessionDataTask *)yy_noCacheGET:(NSString *)URLString
                              parameters:(id)parameters
                         completeHandler:(void (^)(NSURLSessionDataTask *,id responseObject, NSError *))completeHandler {
    return [self GET:URLString
          parameters:parameters
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 completeHandler(task,responseObject, nil);
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 completeHandler(task,nil, error);
             }];
}


- (NSURLSessionDataTask *)yy_syncPOST:(NSString *)URLString
                            parameters:(id)parameters
             constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block
                              progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                               success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                               failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nullable))failure {
    dispatch_semaphore_t t = dispatch_semaphore_create(0);
    NSURLSessionDataTask *task = [self POST:URLString
                                 parameters:parameters
                  constructingBodyWithBlock:block
                                   progress:uploadProgress
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        if (success) {
                                            success(task,responseObject);
                                        }
                                        dispatch_semaphore_signal(t);
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        if (failure) {
                                            failure(task,error);
                                        }
                                        dispatch_semaphore_signal(t);
                                    }];
    dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
    return task;
}

@end
