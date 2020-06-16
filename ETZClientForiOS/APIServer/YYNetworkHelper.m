//
//  YYNetworkHelper.m
//  XXClientForiOS
//
//  Created by yang on 2018/10/22.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "YYNetworkHelper.h"
#import "YYNetworkCache.h"
#import <AFNetworking.h>

@implementation YYNetworkHelper

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure
{
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
            responseCache:(HttpRequestCache)responseCache
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([YYNetworkCache getHttpCacheForKey:URL]) : nil;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    return [manager GET:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [YYNetworkCache saveHttpCache:responseObject forKey:URL] : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                           cacheId:(NSString *)cacheId
                     responseCache:(HttpRequestCache)responseCache
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([YYNetworkCache getHttpCacheForKey:cacheId]) : nil;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    return [manager GET:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [YYNetworkCache saveHttpCache:responseObject forKey:cacheId] : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(HttpRequestCache)responseCache
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([YYNetworkCache getHttpCacheForKey:URL]) : nil;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    return [manager POST:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [YYNetworkCache saveHttpCache:responseObject forKey:URL] : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                            cacheId:(NSString *)cacheId
                      responseCache:(HttpRequestCache)responseCache
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([YYNetworkCache getHttpCacheForKey:cacheId]) : nil;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    return [manager POST:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [YYNetworkCache saveHttpCache:responseObject forKey:cacheId] : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

#pragma mark - 上传图片文件
+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure
{
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    return [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType?mimeType:@"jpeg"]];
        }];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}

#pragma mark - 设置AFHTTPSessionManager
+ (AFHTTPSessionManager *)createAFHTTPSessionManager {
    //打开状态栏的等待菊花
    //    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求参数的类型:HTTP (AFJSONRequestSerializer,AFHTTPRequestSerializer)
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"application/jason/javascript"]];
    return manager;
}


@end
