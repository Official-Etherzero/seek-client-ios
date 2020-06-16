//
//  APINotifyCenter.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/12.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "APINotifyCenter.h"
#import "ClientServer.h"
#import "WalletDataManager.h"
#import "YYInterfaceMacro.h"

@interface APINotifyCenter ()

@property(nonatomic, strong) NSTimer *notify;
@property(nonatomic, assign) NSInteger connectErrorTime;
@property(nonatomic, assign) NSInteger requestCount;

@end

static APINotifyCenter *_instance;
@implementation APINotifyCenter

+ (instancetype)shardInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[APINotifyCenter alloc] init];
    });
    return _instance;
}

// 进入矿工页面关掉请求
// 进入交易页面打开请求
- (void)startNotify {
    if (!self.notify) {
        self.connectErrorTime = 0;
        self.requestCount = 0;
        [self dockSystemStatusNotifyFaster];
    }
}

- (void)stopNotify {
    if (self.notify) {
        [self.notify invalidate];
        self.notify = nil;
    }
}

- (void)dockSystemStatusNotifyFaster {
    if (self.notify) {
        [self.notify invalidate];
        self.notify = nil;
    }
    self.notify = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dockSystemStatusNotify) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.notify forMode:NSDefaultRunLoopMode];
}

- (void)dockSystemStatusNotify {
    WDWeakify(self);
    if ([WalletDataManager getAccountsForDataBase].count > 0) {
        for (AccountModel *item in [WalletDataManager getAccountsForDataBase]) {
            [[ClientServer sharedInstance] getBalanceWithAddress:item.address success:^(NSString * _Nullable suc) {
                if (suc) {
//                    AccountModel *model = [WalletDataManager accountModel];
                    self.requestCount = 0;
                    item.balance = suc;
                    if ([item.address isEqualToString:[WalletDataManager accountModel].address]) {
                        // 当前钱包
                        [[NSNotificationCenter defaultCenter] postNotificationName:kAPIAccountModel object:nil userInfo:@{kAPIAccountModelInfo:item}];
                    }
                    // 所有的钱包都发通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:kAPIWalletList object:nil userInfo:@{kAPIWalletListInfo:item}];
                }
            } failure:^(NSError * _Nullable error) {
                self.requestCount ++;
                if (self.requestCount > 4) {
                    WDStrongify(self);
                    [self stopNotify];
                }
            }];
        }
    }
}

@end
