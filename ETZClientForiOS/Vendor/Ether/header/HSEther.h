//
//  HSEther.h
//  HSEther
//
//  Created by 侯帅 on 2018/4/20.
//  Copyright © 2018年 com.houshuai. All rights reserved.
//
// 1 添加pch文件，全局引入 #import <UIKit/UIKit.h>
// 2 在需要使用的地方 引入 #import "HSEther.h"
// 3 build setting > vaild architectures 去掉对 armv7的支持
#import <Foundation/Foundation.h>
#import "ether.h"
#import "JSModel.h"

typedef NS_ENUM(NSInteger, HSWalletError) {
    HSWalletErrorMnemonicsLength = 0,       //助记词 长度不够
    HSWalletErrorMnemonicsCount = 1,        //助记词 个数不够
    HSWalletErrorMnemonicsValidWord = 2,    //某个 助记词有误（助记词有误）
    HSWalletErrorMnemonicsValidPhrase = 3,  //助记词 有误
    HSWalletErrorPwdLength = 4,             //密码长度不够
    HSWalletErrorKeyStoreLength = 5,        //KeyStore长度不够
    HSWalletErrorKeyStoreValid = 6,         //KeyStore解密失败
    HSWalletErrorPrivateKeyLength = 7,      //私钥长度不够
    HSWalletErrorAddressRepeat = 12,        //钱包导入重复
    
    HSWalletCreateSuc = 8,                  //钱包创建成功
    HSWalletImportMnemonicsSuc = 9,         //助记词导入成功
    HSWalletImportKeyStoreSuc = 10,         //KeyStore导入成功
    HSWalletImportPrivateKeySuc = 11,       //私钥导入成功
    
    HSWalletErrorNotGasPrice = 12,//获取GasPrice失败
    HSWalletErrorNotNonce = 18,//获取Nonce失败
    HSWalletErrorMoneyMin = 13,//转账金额太小 取消使用
    HSWalletErrorNSOrderedDescending = 14, //余额不足 取消使用
    HSWalletErrorPWD = 15, //密码错误
    HSWalletErrorSend = 16, //转账失败
    
    HSWalletSucSend = 17, //转账成功

};

@interface HSEther : NSObject

// https://github.com/wolfhous/HSEther

/**
 创建钱包

 @param pwd 密码
 @param block 创建成功回调
 */
+(void)hs_createWithPwd:(NSString *)pwd
                  block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey))block;


/**
 助记词导入

 @param mnemonics 助记词 12个英文单词 空格分割
 @param pwd 密码
 @param block 导入回调
 */
+(void)hs_inportMnemonics:(NSString *)mnemonics
                      pwd:(NSString *)pwd
                    block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,BOOL suc,HSWalletError error))block;

/**
 KeyStore 导入

 @param keyStore keyStore文本，类似json
 @param pwd 密码
 @param block 导入回调
 */
+(void)hs_importKeyStore:(NSString *)keyStore
                     pwd:(NSString *)pwd
                   block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,BOOL suc,HSWalletError error))block;

/**
 私钥导入

 @param privateKey 私钥
 @param pwd 密码
 @param block 导入回调
 */
+(void)hs_importWalletForPrivateKey:(NSString *)privateKey
                                pwd:(NSString *)pwd
                              block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,BOOL suc,HSWalletError error))block;


/**
 查询余额

 @param arrayToken 查询的代币所有token
 @param address eth地址
 @param block 回调
 */
+(void)hs_getBalanceWithTokens:(NSArray<NSString *> *)arrayToken
                   withAddress:(NSString *)address
                         block:(void(^)(NSArray *arrayBanlance,BOOL suc))block;

/**
 转账

 @param toAddress 转入地址
 @param rpcIP rpc 地址
 @param money 转入金额
 @param contract 代币token 传nil默认为eth
 @param decimal 小数位数
 @param keyStore keyStore
 @param pwd 密码
 @param gasPrice gasPrice （建议10-20）建议传nil，默认位当前节点安全gasPrice
 @param gasLimit gasLimit 不传 默认eth 21000 token 60000
 @param block 回调
 */
+(void)hs_sendToAssress:(NSString *)toAddress
                  rpcIP:(NSString *)rpcIP
                  money:(NSString *)money
               contract:(NSString *)contract
                decimal:(NSString *)decimal
        currentKeyStore:(NSString *)keyStore
                    pwd:(NSString *)pwd
               gasPrice:(NSString *)gasPrice
               gasLimit:(NSString *)gasLimit
                dataStr:(NSString *)dataStr
                  block:(void(^)(NSString *hashStr,BOOL suc,HSWalletError error))block;

/**
 修改密码
 
 @param privateKey 私钥
 @param oldPwd 旧密码
 @param newPwd 新密码
 @param block 导入回调
 */
+(void)hs_changePasswordForPrivateKey:(NSString *)privateKey
                               oldPwd:(NSString *)oldPwd
                               newPwd:(NSString *)newPwd
                                block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,BOOL suc,HSWalletError error))block;

/** 校验 gasLimit
 @param fromAddress 转账地址
 @param toAddress   合约地址
 @param dataString  转账 data
 @Param rpcIP       rpc ip
 @param completionCallback 回调
 */
+(void)yy_estimateGasWithFromAddress:(NSString *)fromAddress
                           toAddress:(NSString *)toAddress
                          dataString:(NSString *)dataString
                               rpcIP:(NSString *)rpcIP
                            keyStore:(NSString *)keyStore
                                 pwd:(NSString *)pwd
                               money:(NSString *)money
                  completionCallback:(void (^)(BigNumberPromise *p))completionCallback;


/** 获取 gasPrice
 @param address 钱包地址
 @param rpcIP   rpc ip
 @param completionCallback 回调
 */

+ (void)yy_getGasPriceWithAddress:(NSString *)address
                            rpcIP:(NSString *)rpcIP
               completionCallback:(void (^)(BigNumberPromise *p))completionCallback;


+(void)yy_getTransactionCostWithFromAddress:(NSString *)fromAddress
                                  toAddress:(NSString *)toAddress
                                 dataString:(NSString *)dataString
                                      rpcIP:(NSString *)rpcIP
                                   keyStore:(NSString *)keyStore
                                        pwd:(NSString *)pwd
                                      money:(NSString *)money
                                    success:(void(^)(BigNumberPromise *gasPrice,BigNumberPromise *gasLimit))success
                                    failure:(void(^)(NSError *error))failure;

/**
 get BlockNumber
 */

+ (void)yy_getNodeBlockNumberWithRpcIP:(NSString *)rpcIP;























@end
