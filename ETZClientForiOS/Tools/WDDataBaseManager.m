//
//  WDDataBaseManager.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDDataBaseManager.h"
#import <Realm/Realm.h>
#import "WDWalletUserInfo.h"
#import "WDMinersInfo.h"

@implementation WDDataBaseManager

+ (void)setDefaultDatabase {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 2;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        [migration enumerateObjects:WDWalletUserInfo.className block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
            if (oldSchemaVersion == 0) {
                newObject[@"address"] = oldObject[@"address"];
                newObject[@"keyStore"] = oldObject[@"keyStore"];
                newObject[@"mnemonicPhrase"] = oldObject[@"mnemonicPhrase"];
                newObject[@"privateKey"] = oldObject[@"privateKey"];
                newObject[@"password"] = oldObject[@"password"];
                newObject[@"userName"] = oldObject[@"userName"];
                newObject[@"decimal"] = @"decimal";
            }
            if (oldSchemaVersion == 1) {
                newObject[@"address"] = oldObject[@"address"];
                newObject[@"keyStore"] = oldObject[@"keyStore"];
                newObject[@"mnemonicPhrase"] = oldObject[@"mnemonicPhrase"];
                newObject[@"privateKey"] = oldObject[@"privateKey"];
                newObject[@"password"] = oldObject[@"password"];
                newObject[@"userName"] = oldObject[@"userName"];
                newObject[@"decimal"] = @"decimal";
                newObject[@"date"] = @"date";
            }
        }];
    };
    
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        [migration enumerateObjects:WDMinersInfo.className block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
            if (oldSchemaVersion == 0) {
            }
        }];
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

@end
