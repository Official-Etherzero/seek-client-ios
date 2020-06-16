//
//  YYNetWorkStatus.m
//  XXClientForiOS
//
//  Created by yang on 2018/10/19.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "YYNetWorkStatus.h"
#import "Reachability.h"

@implementation YYNetWorkStatus {
    Reachability *_reachability;
}

+(instancetype)shareInstance {
    static YYNetWorkStatus *clientState = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        clientState = [[YYNetWorkStatus alloc]init];
    });
    return clientState;
}

-(instancetype)init {
    if (self == [super init]) {
        _reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus status = [_reachability currentReachabilityStatus];
        [self setNetStatusWithReachabilityStatus:status];
        [_reachability startNotifier];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(reachabilityChangeAction:)
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
    }
    return self;
}

-(void)reachabilityChangeAction:(NSNotification *)note
{
    Reachability *currentReach = [note object];
    NetworkStatus status = [currentReach currentReachabilityStatus];
    [self setNetStatusWithReachabilityStatus:status];
}

-(void)setNetStatusWithReachabilityStatus:(NetworkStatus)status {
    switch (status) {
        case NotReachable:
            [self setValue:@(YYNetWorkStateUNKNOWN) forKeyPath:YY_NETWORK_STATE_KEYPATH];
            break;
        case ReachableViaWiFi:
            [self setValue:@(YYNetWorkStateWIFI) forKeyPath:YY_NETWORK_STATE_KEYPATH];
            break;
        case ReachableViaWWAN:
            
        case kReachableVia2G:
            [self setValue:@(YYNetWorkState_2G) forKeyPath:YY_NETWORK_STATE_KEYPATH];
            break;
        case kReachableVia3G:
            [self setValue:@(YYNetWorkState_3G) forKeyPath:YY_NETWORK_STATE_KEYPATH];
            break;
        case kReachableVia4G:
            [self setValue:@(YYNetWorkState_4G) forKeyPath:YY_NETWORK_STATE_KEYPATH];
            break;
            
        default:
            break;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
