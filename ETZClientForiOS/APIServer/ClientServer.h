//
//  ClientServer.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "APIBaseServer.h"
#import "TransferItem.h"
#import "TokenList.h"
#import "RateModel.h"

NS_ASSUME_NONNULL_BEGIN
/** 服务器*/

@interface ClientServer : APIBaseServer

+ (instancetype)sharedInstance;

/** 获取 seek 交易记录列表*/
- (void)getSeekTxListWithAddress:(NSString *)address
                         success:(nullable void (^)(NSArray<TransferItem *> *))success
                         failure:(nullable void (^)(NSError *_Nullable error))failure;

/** 获取矿工等级*/
- (void)getMinerLevelByWalletAddress:(NSString *)address
                             success:(nullable void (^)(long level,id minerInfo))success
                             failure:(nullable void (^)(NSError *_Nullable error))failure;

// 获取矿工json字符串
- (void)getMinerInfoByWalletAddress:(NSString *)address
                           complete:(nullable void (^)(NSString *minerInfo))complete;

/** 获取代币列表*/
- (void)getTokenListComplete:(void (^)(TokenList *list))complete;

/** 获取余额*/
- (NSURLSessionDataTask *)getBalanceWithAddress:(NSString *)address
                                        success:(nullable void (^)(NSString *_Nullable suc))success
                                        failure:(nullable void (^)(NSError *_Nullable error))failure;

/** 评估 gasLimit*/
- (NSURLSessionDataTask *)estimateGas:(NSString *)fromAddress
                            toAddress:(NSString *)toAddress
                           dataString:(NSString *)dataString
                              success:(nullable void (^)(NSString *_Nullable suc))success
                              failure:(nullable void (^)(NSError *_Nullable error))failure;

/** gasPrice 评估*/
- (NSURLSessionDataTask *)getGasPriceSuccess:(nullable void (^)(NSString *_Nullable suc))success
                                     failure:(nullable void (^)(NSError *_Nullable error))failure;

- (void)getUsdtPriceComplete:(nullable void (^)(NSString *pirce,NSError *error))complete;

- (void)getExchangeRateComplete:(nullable void (^)(NSArray<RateModel *> *rates,NSError *error))complete;

- (void)getRatesComplete:(nullable void (^)(NSArray<RateModel *> *rates,float usdt,NSError *error))complete;



@end

NS_ASSUME_NONNULL_END
