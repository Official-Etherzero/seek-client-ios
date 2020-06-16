//
//  WDWalletUserInfo.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDWalletUserInfo.h"

@implementation WDWalletUserInfo

+ (NSString *)primaryKey {
    return @"privateKey";
}

+ (WDWalletUserInfo *)initWithAccountModel:(AccountModel *)model {
    WDWalletUserInfo *info = [[WDWalletUserInfo alloc] init];
    info.address = model.address;
    info.keyStore = model.keyStore;
    info.mnemonicPhrase = model.mnemonicPhrase;
    info.privateKey = model.privateKey;
    info.password = model.password;
    info.userName = model.userName;
    info.decimal = model.decimal;
    info.date = model.date;
    return info;
}

+ (void)addAccount:(AccountModel *)model {
    
    WDWalletUserInfo *info = [WDWalletUserInfo initWithAccountModel:model];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:info];
    [realm commitWriteTransaction];
}

+ (void)removeAccount:(AccountModel *)model {
    RLMResults *accounts = [WDWalletUserInfo allObjects];
    for (WDWalletUserInfo *key in accounts) {
        if ([key.privateKey isEqualToString:model.privateKey]) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm deleteObject:key];
            [realm commitWriteTransaction];
        }
    }
}

+ (void)updateAccount:(AccountModel *)model {
    WDWalletUserInfo *info = [WDWalletUserInfo initWithAccountModel:model];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:info];
    [realm commitWriteTransaction];
}


@end
