//
//  YYUserDefaluts.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYUserDefaluts.h"
#import "AccountModel.h"
#import "WalletDataManager.h"

@implementation YYUserDefaluts

+ (void)yy_setAccountModelIndex:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"KLRow"];
}

+ (NSInteger)yy_getAccountModelIndex {
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"KLRow"];
    return index;
}

+ (void)yy_updateAccountIndex:(AccountModel *)model {
    NSArray *arr = [WalletDataManager getAccountsForDataBase];
    NSInteger index = 0;
    for (int i = 0; i < arr.count; i ++) {
        AccountModel *item = arr[i];
        if ([model.address isEqualToString:item.address]) {
            index = i;
        }
    }
    NSInteger currentIndex = [self yy_getAccountModelIndex];
    if (index <= currentIndex) {
        if (currentIndex > 0) {
           [self yy_setAccountModelIndex:currentIndex -1];
        }
    }
}

@end
