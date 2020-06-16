//
//  YYAddress.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/12.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYAddress.h"
#import "WalletDataManager.h"

@implementation YYAddress

+ (BOOL)isEthAddressByPatten:(NSString *)pattern {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^0[xX][0-9a-fA-F]{40}$"] evaluateWithObject:pattern];
}

@end
