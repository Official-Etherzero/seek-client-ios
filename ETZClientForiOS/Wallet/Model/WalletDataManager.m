//
//  WalletDataManager.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WalletDataManager.h"
#import "WDWalletUserInfo.h"
#import "AccountModel.h"
#import "YYUserDefaluts.h"

@implementation WalletDataManager

+ (NSArray<AccountModel *> *)getAccountsForDataBase {
    NSMutableArray *arr = [NSMutableArray array];
    RLMResults *infos = [WDWalletUserInfo allObjects];
    if (infos.count > 0) {
        for (WDWalletUserInfo *info in infos) {
            AccountModel *model = [[AccountModel alloc] initWithWalletUserInfo:info];
            [arr addObject:model];
        }
    }
    return arr;
}

+ (NSArray<TokenItem *> *)getTokenListForServer {
    return nil;
}

+ (NSArray *)funcImages {
   return @[@"scan",@"zhuanzhang",@"shoukuan",@"miner"];
}

+ (NSArray *)funcTitles {
    return @[@"扫一扫",@"转账",@"收款",@"矿工"];
}

+ (AccountModel *)accountModel {
    NSInteger index = [YYUserDefaluts yy_getAccountModelIndex];
    AccountModel *model;
    if (index >= 0) {
        model = [WalletDataManager getAccountsForDataBase][index];
    }
    return model;
}

+ (NSInteger)currentIndex {
    NSInteger index = [YYUserDefaluts yy_getAccountModelIndex];
    return index;
}

+ (void)yy_updateCurrentAccountModel {
    NSInteger index = [YYUserDefaluts yy_getAccountModelIndex];
    if (index > 1) {
        [YYUserDefaluts yy_setAccountModelIndex:index-1];
    }
}

+ (BOOL)yy_walletIsExistByWalletAddress:(NSString *)walletAddress {
    NSArray *walletArr = [self getAccountsForDataBase];
    if (walletArr.count == 0) {
        return NO;
    }  else {
        for (AccountModel *model in walletArr) {
            if ([model.address isEqualToString:walletAddress]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
