//
//  ClientEtherAPI.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
#import "JSModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClientEtherAPI : NSObject

/** 创建钱包*/
+(void)yy_createWalletWithUserName:(NSString *)userName
                          password:(NSString *)password
                     completeBlock:(void(^)(AccountModel *model))block;

/** 修改密码*/
+ (void)yy_changePasswordWithPrivateKey:(NSString *)privateKey
                                 oldPsw:(NSString *)oldPsd
                                 newPsd:(NSString *)newPsd
                                success:(void(^)(NSString *key,NSString *keystore))success
                                failure:(void(^)(NSError *error))failure;

/** 这些数据其实可以直接从数据库中去拿，创建的时候就已经确认好了*/
/** 导出私钥*/
+ (void)yy_importPrivateKeyWithAccountModel:(AccountModel *)model
                                    success:(void(^)(NSString *privateKey))success
                                    failure:(void(^)(NSError *error))failure;

/** 导出 keystore*/
+ (void)yy_importKeystoreWithAccountModel:(AccountModel *)model
                                  success:(void(^)(NSString *keysotre))success
                                  failure:(void(^)(NSError *error))failure;
/** 发送交易*/
+(void)yy_sendToAssress:(NSString *)toAddress
                  money:(NSString *)money
        currentKeyStore:(NSString *)keyStore
                    pwd:(NSString *)pwd
               gasPrice:(NSString *)gasPrice
               gasLimit:(NSString *)gasLimit
                dataStr:(NSString *)dataStr
                  block:(void(^)(NSString *hashStr,BOOL suc,NSError *error))block;

/** 校验 gaslimit*/
+(void)yy_estimateGasWithFromAddress:(NSString *)address
                             JSModel:(JSModel *)jsModel
                             success:(void(^)(NSString *gasLimit))success
                             failure:(void(^)(NSError *error))failure;

/** 获取 gasPrice*/
+ (void)yy_getGasPriceWithAddress:(NSString *)address
                          success:(void(^)(NSString *gasPrice))success
                          failure:(void(^)(NSError *error))failure;

/**
 @parm address           转账地址
 @parm contractAddress   合约地址
 @parm dataString        data 数据
 @parm money             转账金额
 
 @parm gasPrice
 @parm gasLimit
 @parm cost
 */
+ (void)yy_getTransactionCostWithFromAddress:(NSString *)formAddress
                                   toAddress:(NSString *)toAddress
                                  dataString:(NSString *)dataString
                                       money:(NSString *)money
                                     success:(void(^)(NSString *gasPrice,NSString *gasLimit,NSString *cost))success
                                     failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
