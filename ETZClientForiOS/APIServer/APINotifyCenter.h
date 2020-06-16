//
//  APINotifyCenter.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/12.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APINotifyCenter : NSObject

+ (instancetype)shardInstance;

- (void)startNotify;

- (void)stopNotify;

@end

NS_ASSUME_NONNULL_END
