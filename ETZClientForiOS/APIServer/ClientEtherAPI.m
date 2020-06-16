//
//  ClientEtherAPI.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "ClientEtherAPI.h"
#import "HSEther.h"
#import "YYSettingNode.h"
#import "YYInterfaceMacro.h"
#import "YYCalculateModel.h"
#import "WalletDataManager.h"

@implementation ClientEtherAPI

+(void)yy_createWalletWithUserName:(NSString *)userName
                          password:(NSString *)password
                     completeBlock:(void(^)(AccountModel *model))block {
    [HSEther hs_createWithPwd:password block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey) {
        if (address && mnemonicPhrase) {
            // 成功创建钱包 // 只有验证完助记词才能算是真正的写入数据库
            // 这里传 model
            AccountModel *model = [AccountModel new];
            model.address = address;
            model.keyStore = keyStore;
            model.mnemonicPhrase = mnemonicPhrase;
            model.privateKey = privateKey;
            model.decimal = @"18";
            model.userName = userName;
            model.password = password;
            block(model);
        } else {
           block(nil);
        }
    }];
}

+ (void)yy_changePasswordWithPrivateKey:(NSString *)privateKey
                                 oldPsw:(NSString *)oldPsd
                                 newPsd:(NSString *)newPsd
                                success:(void(^)(NSString *key,NSString *keystore))success
                                failure:(void(^)(NSError *error))failure {
    [HSEther hs_changePasswordForPrivateKey:privateKey oldPwd:oldPsd newPwd:newPsd block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        if (suc) {
            if (success) {
                success(privateKey,keyStore);
            }
        }
        if (error) {
            if (failure) {
                NSError *error = nil;
                failure(error);
            }
        }
    }];
}

+ (void)yy_importPrivateKeyWithAccountModel:(AccountModel *)model
                                    success:(void(^)(NSString *privateKey))success
                                    failure:(void(^)(NSError *error))failure {
    [HSEther hs_importWalletForPrivateKey:model.privateKey pwd:model.password block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        if (error) {
            NSError *error = nil;
            if (failure) {
                failure(error);
            }
        }
        if (suc) {
            if (success) {
                success(privateKey);
            }
        }
    }];
}

/** 导出 keystore*/
+ (void)yy_importKeystoreWithAccountModel:(AccountModel *)model
                                  success:(void(^)(NSString *keysotre))success
                                  failure:(void(^)(NSError *error))failure {
    [HSEther hs_importKeyStore:model.keyStore pwd:model.password block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        if (error) {
            NSError *error = nil;
            if (failure) {
                failure(error);
            }
        }
        if (suc) {
            if (success) {
                success(keyStore);
            }
        }
    }];
}

+(void)yy_sendToAssress:(NSString *)toAddress
                  money:(NSString *)money
        currentKeyStore:(NSString *)keyStore
                    pwd:(NSString *)pwd
               gasPrice:(NSString *)gasPrice
               gasLimit:(NSString *)gasLimit
                dataStr:(NSString *)dataStr
                  block:(void(^)(NSString *hashStr,BOOL suc,NSError *error))block {
    // contract 普通交易为 nil， decimal 默认为 18
    [HSEther hs_sendToAssress:toAddress rpcIP:[YYSettingNode currentNodeIp] money:money contract:nil decimal:@"18" currentKeyStore:keyStore pwd:pwd gasPrice:gasPrice gasLimit:gasLimit dataStr:dataStr block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
        if (block) {
            NSError *error;
            block(hashStr,suc,error);
        }
    }];
}

+(void)yy_estimateGasWithFromAddress:(NSString *)address
                             JSModel:(JSModel *)jsModel
                             success:(void(^)(NSString *gasLimit))success
                             failure:(void(^)(NSError *error))failure {
    [HSEther yy_estimateGasWithFromAddress:address toAddress:jsModel.contractAddress dataString:jsModel.datas rpcIP:[YYSettingNode currentNodeIp] keyStore:[WalletDataManager accountModel].keyStore pwd:[WalletDataManager accountModel].password money:[YYCalculateModel yy_calculateDividedWithNumString:jsModel.etzValue] completionCallback:^(BigNumberPromise *p) {
        if (p.error) {
            if (failure) {
                failure(p.error);
            }
        } else {
            success(p.value.decimalString);
        }
    }];
}

+ (void)yy_getGasPriceWithAddress:(NSString *)address
                          success:(void (^)(NSString * _Nonnull))success
                          failure:(void (^)(NSError * _Nonnull))failure {
    [HSEther yy_getGasPriceWithAddress:address rpcIP:[YYSettingNode currentNodeIp] completionCallback:^(BigNumberPromise *p) {
        if (p.error) {
            if (failure) {
                failure(p.error);
            }
        } else {
            NSString *valueStr = [YYCalculateModel yy_calculateDividedByGasPrice:p.value.decimalString];
            success(valueStr);
        }
    }];
}

+ (void)yy_getTransactionCostWithFromAddress:(NSString *)formAddress
                                   toAddress:(NSString *)toAddress
                                  dataString:(NSString *)dataString
                                       money:(NSString *)money
                                     success:(void(^)(NSString *gasPrice,NSString *gasLimit,NSString *cost))success
                                     failure:(void(^)(NSError *error))failure {
    [HSEther yy_getTransactionCostWithFromAddress:formAddress toAddress:toAddress dataString:dataString rpcIP:[YYSettingNode currentNodeIp] keyStore:[WalletDataManager accountModel].keyStore pwd:[WalletDataManager accountModel].password money:money success:^(BigNumberPromise *gasPrice, BigNumberPromise *gasLimit) {
        if (success) {
            NSString *price = [YYCalculateModel yy_calculateDividedByGasPrice:gasPrice.value.decimalString];
            NSInteger p = [price integerValue];
            if (p < 1) {
                p = 1;
            } else if (p > 100) {
                p = 100;
            }
            NSString *priceValue = [NSString stringWithFormat:@"%ld",(long)p];
            NSString *limit = gasLimit.value.decimalString;
            NSString *cost = [YYCalculateModel yy_calculateMultiplyedWithPrice:priceValue limit:limit];
            success(priceValue,limit,cost);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
