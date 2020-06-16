//
//  YYNetworkCache.m
//  XXClientForiOS
//
//  Created by yang on 2018/10/22.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "YYNetworkCache.h"
#import "YYCache.h"

@implementation YYNetworkCache

static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)saveHttpCache:(id)httpCache forKey:(NSString *)key {
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpCache forKey:key withBlock:nil];
}

+ (id)getHttpCacheForKey:(NSString *)key {
    return [_dataCache objectForKey:key];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

@end
