//
//  TokenDataManager.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/2.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransferDetailItem.h"
#import "TokenItem.h"
#import "AccountModel.h"
#import "TransferItem.h"

/** 这里的接口可以合二为一，也可以分开写*/
/** 合二为一的话则是代币的交易记录列表放到代币的子目录中去*/

NS_ASSUME_NONNULL_BEGIN

@interface TokenDataManager : NSObject

/** 默认数据来自于 AccountModel*/
+ (TokenItem *)updateDefaultTokenItemByModel:(AccountModel *)model;

/** 拿到代币列表*/
+ (NSArray<TokenItem *> *)getTokenList;

+ (NSArray<TransferDetailItem *> *)getToeknTransferList;

/** 拿到代币的交易记录*/
+ (NSArray<TransferItem *> *)getTransferListByAccountModel:(AccountModel *)model;

@end

NS_ASSUME_NONNULL_END
