//
//  WalletDataManager.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenItem.h"
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalletDataManager : NSObject

+ (NSArray<AccountModel *> *)getAccountsForDataBase;

+ (NSArray<TokenItem *> *)getTokenListForServer;

+ (NSArray *)funcTitles;

+ (NSArray *)funcImages;

+ (AccountModel *)accountModel;

+ (NSInteger)currentIndex;

+ (void)yy_updateCurrentAccountModel;

+ (BOOL)yy_walletIsExistByWalletAddress:(NSString *)walletAddress;


@end

NS_ASSUME_NONNULL_END
