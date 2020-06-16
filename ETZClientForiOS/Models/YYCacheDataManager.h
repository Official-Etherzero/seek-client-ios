//
//  YYCacheDataManager.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/14.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCacheDataManager : NSObject

+ (void)addTokenTransferObjectWithAddress:(NSString *)address
                           responseObject:(id)responseObject;

+ (NSArray *)getTokenTransferObjectListWithAddress:(NSString *)address;

+ (void)clearDataWithAddress:(NSString *)address;

#pragma mark - public cache

+ (void)addObjectWithCacheKey:(NSString *)cacheKey
                   responseObject:(id)responseObject;

+ (id)getObjectWithCacheKey:(NSString *)cacheKey;

+ (void)clearCacheDataWithCacheKey:(NSString *)cacheKey;



@end

NS_ASSUME_NONNULL_END
