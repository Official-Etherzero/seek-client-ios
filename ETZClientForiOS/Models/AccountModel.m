//
//  AccountModel.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "AccountModel.h"
#import "WDWalletUserInfo.h"

@implementation AccountModel

- (instancetype)initWithWalletUserInfo:(WDWalletUserInfo *)info {
    if (self = [super init]) {
        self.address = info.address;
        self.keyStore = info.keyStore;
        self.mnemonicPhrase = info.mnemonicPhrase;
        self.privateKey = info.privateKey;
        self.password = info.password;
        self.userName = info.userName;
        self.decimal = info.decimal;
        
        // 余额和等级默认为 0
//        self.level = @"0";
        self.balance = @"0";
    }
    return self;
}


@end
