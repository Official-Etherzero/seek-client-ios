//
//  APIBaseServer.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/7.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIBaseServer : NSObject

- (AFHTTPSessionManager *)getCMDManagerWithTimeout:(NSTimeInterval)timeout;

- (NSString *)rpcHost;

- (NSString *)host;

- (NSString *)blockHost;

- (NSString *)tokenHost;

- (NSString *)btcHost;

- (NSString *)usdtHost;

@end

NS_ASSUME_NONNULL_END
