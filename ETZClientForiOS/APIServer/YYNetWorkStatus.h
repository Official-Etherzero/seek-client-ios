//
//  YYNetWorkStatus.h
//  XXClientForiOS
//
//  Created by yang on 2018/10/19.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *YY_NETWORK_STATE_KEYPATH = @"netStatus";

typedef NS_ENUM(NSInteger,NetWorkStatus){
    
    YYNetWorkStateUNKNOWN = 0,
    YYNetWorkStateWIFI    = 1,//wifi
    YYNetWorkState_2G     = 2,//2g
    YYNetWorkState_3G     = 3,//3g
    YYNetWorkState_4G     = 4,//4g
};

@interface YYNetWorkStatus : NSObject

+(instancetype)shareInstance;

@property(nonatomic, assign) NetWorkStatus netWorkStatus;

@end

NS_ASSUME_NONNULL_END
