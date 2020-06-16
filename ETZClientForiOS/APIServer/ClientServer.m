//
//  ClientServer.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "ClientServer.h"
#import "YYNetworkHelper.h"
#import "OCMapper.h"
#import "TransferItem.h"
#import "YYModel.h"
#import "HSEther.h"
#import "AFHTTPSessionManager+Ext.h"
#import "YYDateModel.h"
#import "ether.h"
#import "YYCalculateModel.h"
#import "YYInterfaceMacro.h"
#import "YYCacheDataManager.h"
#import "YYInterfaceMacro.h"
#import "MinerModel.h"
#import "NSString+Ext.h"
#import "HttpModel.h"

// http://159.65.133.190:8545

// http://159.65.133.190:7002

// https://www.easyetz.io/etzq/api/v1/getTokenList

@interface ClientServer ()

@property (nonatomic, strong) NSURLSession *httpSession;
@property (nonatomic, strong) NSMutableArray <RateModel *>*models;

@end

@implementation ClientServer

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ClientServer *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ClientServer alloc] init];
    });
    return instance;
}

#pragma mark - method

- (void)getSeekTxListWithAddress:(NSString *)address
                         success:(nullable void (^)(NSArray<TransferItem *> *))success
                         failure:(nullable void (^)(NSError *_Nullable error))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@/api/v1/getEtzTxlist?address=%@",[self blockHost],address];
    [YYNetworkHelper GET:urlString parameters:nil success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            NSMutableArray *list = [NSMutableArray array];
            HttpModel *model = [HttpModel yy_modelWithJSON:responseObject];
            [YYCacheDataManager clearDataWithAddress:address];
            [YYCacheDataManager addTokenTransferObjectWithAddress:address responseObject:responseObject];
            if (model.result && model.result.count > 0) {
                for (id value in model.result) {
                    TransferItem *item = [TransferItem yy_modelWithJSON:value];
                    [list addObject:item];
                }
            }
            if (success) {
                success(list);
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getMinerLevelByWalletAddress:(NSString *)address
                             success:(nullable void (^)(long level,id minerInfo))success
                             failure:(nullable void (^)(NSError *_Nullable error))failure {
    // http://134.209.104.209:3001/api/miner_more?address=0x7988A5E28fD17269D6cF274873C0024C6143001F
    // host
    NSString *urlString = [NSString stringWithFormat:@"%@/api/miner_more",[self host]];
    NSDictionary *param = @{
                            @"address": address,
                            };
    [YYNetworkHelper POST:urlString parameters:param success:^(id  _Nonnull responseObject) {
        id value = responseObject[@"resp"];
        if (![value isEqual:[NSNull null]]) {
            MinerModel *model = [MinerModel yy_modelWithJSON:[value objectForKey:@"miner"]];
            NSLog(@"矿工等级   %ld",model.level);
            success(model.level,responseObject);
        } else {
            // 未注册矿工
            NSLog(@"当前未注册矿工");
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (void)getMinerInfoByWalletAddress:(NSString *)address
                           complete:(nullable void (^)(NSString *minerInfo))complete {
    NSString *urlString = [NSString stringWithFormat:@"%@/api/miner_more",[self host]];
    NSDictionary *param = @{
                            @"address": address,
                            };
    [YYNetworkHelper POST:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if (complete) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *jsonStr = [NSString yy_dictionaryToJson:responseObject];
                complete(jsonStr);
            } else {
                complete(nil);
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (complete) {
            complete(nil);
        }
    }];
}

- (void)getTokenListComplete:(void (^)(TokenList * _Nonnull))complete {
    NSString *urlString = [NSString stringWithFormat:@"%@/etzq/api/v1/getTokenList",[self tokenHost]];
    [YYNetworkHelper GET:urlString parameters:nil success:^(id  _Nonnull responseObject) {
        TokenList *modelList = [TokenList new];
        NSArray *arr = [responseObject objectForKey:@"result"];
        [YYCacheDataManager addObjectWithCacheKey:kTokenList responseObject:responseObject];
        if (arr.count > 0) {
            for (id value in arr) {
                TokenModel *model = [TokenModel yy_modelWithJSON:value];
                [modelList.tokenList addObject:model];
            }
        }
        complete(modelList);
    } failure:^(NSError * _Nonnull error) {
        TokenList *list = [TokenList new];
        list.errorModel.code = error.code;
        list.errorModel.msg = error.localizedDescription;
        list.errorModel.error = error;
        complete(list);
    }];
}

- (NSURLSessionDataTask *)getBalanceWithAddress:(NSString *)address
                                        success:(nullable void (^)(NSString *_Nullable suc))success
                                        failure:(nullable void (^)(NSError *_Nullable error))failure {
    NSArray *arr = @[address,@"latest"];
    NSDictionary *param = @{
                            @"id": @(42),
                            @"jsonrpc": @"2.0",
                            @"method": @"eth_getBalance",
                            @"params": arr,
                            };
    
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self rpcHost]]];
    request.HTTPBody = body;
    request.HTTPMethod = @"POST";
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setTimeoutInterval:10.0f];
    
    NSURLSessionDataTask *task = [self.httpSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            // 拿到 value值是 18 位的数据
            if (json && !json[@"error"]) {
                BigNumber *value = [BigNumber bigNumberWithHexString:json[@"result"]];
                NSString *valueStr = [YYCalculateModel yy_calculateDividedWithNumString:value.decimalString];
                success(valueStr);
            } else {
                if (failure) {
                    failure(json[@"error"]);
                }
            }
        } else if (error) {
            if (failure) {
                failure(error);
            }
        }
    }];
    [task resume];
    return task;
}

/** 评估 gasLimit*/
- (NSURLSessionDataTask *)estimateGas:(NSString *)fromAddress
                            toAddress:(NSString *)toAddress
                           dataString:(NSString *)dataString
                              success:(nullable void (^)(NSString *_Nullable suc))success
                              failure:(nullable void (^)(NSError *_Nullable error))failure {
    /** 评估 gaslimit 需要传交易参数*/
    __block Transaction *transaction = [Transaction transactionWithFromAddress:[Address addressWithString:fromAddress]];
    transaction.toAddress = [Address addressWithString:toAddress];
    NSData  *tansferData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    transaction.data = tansferData;
    NSDictionary *param = @{
                            @"method": @"eth_estimateGas",
                            @"params": transaction,
                            };
    
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self rpcHost]]];
    request.HTTPBody = body;
    request.HTTPMethod = @"POST";
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setTimeoutInterval:10.0f];
    
    NSURLSessionDataTask *task = [self.httpSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            // 拿到 value值是 18 位的数据
            BigNumber *value = [BigNumber bigNumberWithHexString:json[@"result"]];
            NSString *valueStr = [YYCalculateModel yy_calculateDividedWithNumString:value.decimalString];
            success(valueStr);
        } else if (error) {
            if (failure) {
                failure(error);
            }
        }
    }];
    [task resume];
    return task;
}

/** gasPrice 评估*/
- (NSURLSessionDataTask *)getGasPriceSuccess:(nullable void (^)(NSString *_Nullable suc))success
                                     failure:(nullable void (^)(NSError *_Nullable error))failure {
    /** 获取 gasPrice 传一个方法名*/
    NSDictionary *param = @{ @"method": @"eth_gasPrice" };
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self rpcHost]]];
    request.HTTPBody = body;
    request.HTTPMethod = @"POST";
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setTimeoutInterval:10.0f];
    
    NSURLSessionDataTask *task = [self.httpSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            // 拿到 value值是 18 位的数据
            BigNumber *value = [BigNumber bigNumberWithHexString:json[@"result"]];
            NSString *valueStr = [YYCalculateModel yy_calculateDividedWithNumString:value.decimalString];
            success(valueStr);
        } else if (error) {
            if (failure) {
                failure(error);
            }
        }
    }];
    [task resume];
    return task;
}

- (void)getUsdtPriceComplete:(nullable void (^)(NSString *pirce,NSError *error))complete {
    
}

- (void)getExchangeRateComplete:(nullable void (^)(NSArray<RateModel *> *rates,NSError *error))complete {
    
}

- (void)getRatesComplete:(nullable void (^)(NSArray<RateModel *> *rates,float usdt,NSError *error))complete {
    [YYNetworkHelper GET:[self usdtHost] parameters:nil success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            float usdtPrice = [[responseObject objectForKey:@"price"] floatValue];
            [YYNetworkHelper GET:[self btcHost] parameters:nil success:^(id  _Nonnull responseObject) {
                // 拿到价格了
                if (responseObject) {
                    NSLog(@"usdtPrice = %f,responseObject = %@",usdtPrice,responseObject);
                    if (self.models && self.models.count > 0) {
                        [self.models removeAllObjects];
                    }
                    if (responseObject) {
                        for (id value in responseObject) {
                            RateModel *model = [RateModel yy_modelWithJSON:value];
                            if ([model.code isEqualToString:@"USD"] ||
                                [model.code isEqualToString:@"CNY"] ||
                                [model.code isEqualToString:@"KRW"] ||
                                [model.code isEqualToString:@"BTC"]) {
                                [self.models addObject:model];
                            }
                        }
                        complete(self.models,usdtPrice,nil);
                    }
                }
            } failure:^(NSError * _Nonnull error) {
                 complete(nil,0,error);
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        complete(nil,0,error);
    }];
}

#pragma mark -

- (NSURLSession *)httpSession {
    if (!_httpSession) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        _httpSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    }
    return _httpSession;
}

#pragma mark -

- (NSMutableArray<RateModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
