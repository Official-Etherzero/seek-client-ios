//
//  YYCacheDataManager.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/14.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYCacheDataManager.h"
#import "TransferItem.h"
#import "YYModel.h"
#import "HttpModel.h"

static NSString *kTransferLitstName = @"kSeek0x.......data";
static NSString *kTransferListKey = @"kSeek0x......";
static NSString *kCache = @"0x.....";
static NSMutableDictionary *transferListDictionary;

@implementation YYCacheDataManager

+ (void)addTokenTransferObjectWithAddress:(NSString *)address
                           responseObject:(id)responseObject {
    NSMutableDictionary *transferDictionary = [transferListDictionary objectForKey:address];
    if (!transferDictionary) {
        transferDictionary = [[NSMutableDictionary alloc] init];
        [transferListDictionary setObject:transferDictionary forKey:address];
    }
    [transferListDictionary setObject:responseObject forKey:address];
    [self writeDataToFile:address];
}

+ (void)writeDataToFile:(NSString *)str {
    NSString *ktransferListName = [NSString stringWithFormat:@"kSeek%@.data",str];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[paths firstObject] stringByAppendingPathComponent:ktransferListName];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:transferListDictionary];
    [data writeToFile:fileName atomically:YES];
}

+ (NSArray *)getTokenTransferObjectListWithAddress:(NSString *)address {
    NSString *ktransferListName = [NSString stringWithFormat:@"kSeek%@.data",address];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[paths firstObject] stringByAppendingPathComponent:ktransferListName];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileName]) {
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        transferListDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else{
        transferListDictionary = [[NSMutableDictionary alloc] init];
    }
    NSDictionary *listDictionary = [transferListDictionary objectForKey:address];
    HttpModel *model = [HttpModel yy_modelWithJSON:listDictionary];
    NSMutableArray *list = [NSMutableArray array];
    if (model.result.count > 0) {
        for (id value in model.result) {
            TransferItem *item = [TransferItem yy_modelWithJSON:value];
            [list addObject:item];
        }
    }
    return list;
}

+ (void)clearDataWithAddress:(NSString *)address {
    if (transferListDictionary) {
        [transferListDictionary removeAllObjects];
        [self writeDataToFile:address];
    }
}

#pragma mark - public cache

+ (void)addObjectWithCacheKey:(NSString *)cacheKey
               responseObject:(id)responseObject {
    NSMutableDictionary *transferDictionary = [transferListDictionary objectForKey:cacheKey];
    if (!transferDictionary) {
        transferDictionary = [[NSMutableDictionary alloc] init];
        [transferListDictionary setObject:transferDictionary forKey:cacheKey];
    }
    [transferListDictionary setObject:responseObject forKey:cacheKey];
    [self writeCacheDataToFile:cacheKey];
}

+ (void)writeCacheDataToFile:(NSString *)cacheyKey {
    NSString *ktransferListName = [NSString stringWithFormat:@"%@.data",cacheyKey];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[paths firstObject] stringByAppendingPathComponent:ktransferListName];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:transferListDictionary];
    [data writeToFile:fileName atomically:YES];
}

+ (id)getObjectWithCacheKey:(NSString *)cacheKey {
    NSString *ktransferListName = [NSString stringWithFormat:@"%@.data",cacheKey];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[paths firstObject] stringByAppendingPathComponent:ktransferListName];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileName]) {
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        transferListDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else{
        transferListDictionary = [[NSMutableDictionary alloc] init];
    }
    NSDictionary *listDictionary = [transferListDictionary objectForKey:cacheKey];
    return listDictionary;
}

+ (void)clearCacheDataWithCacheKey:(NSString *)cacheKey {
    if (transferListDictionary) {
        [transferListDictionary removeAllObjects];
        [self writeCacheDataToFile:cacheKey];
    }
}

@end
