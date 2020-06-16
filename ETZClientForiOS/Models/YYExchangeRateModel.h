//
//  YYExchangeRateModel.h
//  ETZClientForiOS
//
//  Created by etz on 2019/11/14.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYExchangeRateModel : NSObject

+ (NSArray <RateModel *>*)yy_exchangeRateByModels:(NSArray<RateModel *> *)models usdtPrice:(float)usdtPrice;

+ (NSString *)yy_getPriceByModels:(NSArray<RateModel *> *)models balance:(NSString *)balance;

@end

NS_ASSUME_NONNULL_END
