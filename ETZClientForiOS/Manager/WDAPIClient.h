//
//  WDAPIClient.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYErrorModel.h"

// rpc   http://159.65.133.190:8545
// ceshi http://159.65.133.190:7002
NS_ASSUME_NONNULL_BEGIN

#define proto       @"https"
#define protohttp   @"http"
#define host        @"etzrpc.org:443"
#define testhost    @"easyetz.io"
#define tokenshost  @"etzscan.com"

#define transferEventSignature @"0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"

@interface WDAPIClient : NSObject

/** 查询余额 get balance*/



/** 获取 gas 值 get gas price*/

/** gas 评估 estimate Gas*/

/** 发送交易 sendRawTransaction*/

/** pow 值 get power*/

/** 交易记录 get tx list*/

/** 代币余额 get token balance*/

/** 代币交易记录 get token transferLogs*/

/** 代币列表 get tokens list*/


@end

NS_ASSUME_NONNULL_END
