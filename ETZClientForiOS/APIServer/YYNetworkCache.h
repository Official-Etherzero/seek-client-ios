//
//  YYNetworkCache.h
//  XXClientForiOS
//
//  Created by yang on 2018/10/22.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkCache : NSObject

/**
 *  缓存网络数据
 *
 *  @param httpCache x
 *  @param key           缓存数据对应的key值,推荐填入请求的URL
 */
+ (void)saveHttpCache:(id)httpCache forKey:(NSString *)key;

/**
 *  取出缓存的数据
 *
 *  @param key 根据存入时候填入的key值来取出对应的数据
 *
 *  @return 缓存的数据
 */
+ (id)getHttpCacheForKey:(NSString *)key;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;

/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache;

@end

NS_ASSUME_NONNULL_END
