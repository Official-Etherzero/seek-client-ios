//
//  APIBaseServer.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/7.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "APIBaseServer.h"
#import "AFHTTPSessionManager+Ext.h"
#import "YYSettingNode.h"

@implementation APIBaseServer

- (NSString *)rpcHost {
    return [YYSettingNode currentNodeIp];
}

- (NSString *)blockHost {
    return @"http://13.251.6.203:7002";
}

- (NSString *)host {
    return @"http://13.251.6.203:3001";
}

- (NSString *)tokenHost {
    return @"https://www.easyetz.io";
}

- (NSString *)btcHost {
    return @"https://bitpay.com/api/rates";
}

- (NSString *)usdtHost {
    return @"https://api.hoo.com/tickers/seekusdt";
}

- (AFHTTPSessionManager *)getCMDManagerWithTimeout:(NSTimeInterval)timeout {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager yy_manager];
    });
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:timeout];
    [manager.requestSerializer setValue:@"no-cache" forHTTPHeaderField:@"Cache-control"];
    return manager;
}

@end
