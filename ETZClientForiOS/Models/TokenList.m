//
//  TokenList.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/17.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TokenList.h"
#import "YYInterfaceMacro.h"
#import "YYCacheDataManager.h"
#import "YYModel.h"

@implementation TokenList

+ (NSArray<TokenModel *> *)getCacheTokenList {
    id object = [YYCacheDataManager getObjectWithCacheKey:kTokenList];
    NSMutableArray *list = [NSMutableArray array];
    NSArray *arr = [object objectForKey:@"result"];
    if (arr.count > 0) {
        for (id value in arr) {
            TokenModel *model = [TokenModel yy_modelWithJSON:value];
            [list addObject:model];
        }
    }
    return list;
}

@end
