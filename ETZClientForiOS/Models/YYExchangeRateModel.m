//
//  YYExchangeRateModel.m
//  ETZClientForiOS
//
//  Created by etz on 2019/11/14.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYExchangeRateModel.h"
#import "YYLanguageTool.h"

@implementation YYExchangeRateModel

+ (NSArray <RateModel *>*)yy_exchangeRateByModels:(NSArray<RateModel *> *)models usdtPrice:(float)usdtPrice {
    // usdt 转换成 btc
    float btcRate = 0;
    NSMutableArray *arr = [NSMutableArray array];
    for (RateModel *model in models) {
        if ([model.code isEqualToString:@"USD"]) {
            btcRate = usdtPrice / model.rate;
        }
    }
    
    for (RateModel *model in models) {
        model.price = model.rate * btcRate;
        [arr addObject:model];
    }
    return arr;
}

+ (NSString *)yy_getPriceByModels:(NSArray<RateModel *> *)models balance:(NSString *)balance {
    if (!balance) {
        balance = @"0";
    }
    YYSettingLanguageType type = [[YYLanguageTool shareInstance] currentType];
    NSString *str;
    switch (type) {
        case YYSettingLanguageTypeChineseSimple: {
            for (RateModel *model in models) {
                if ([model.code isEqualToString:@"CNY"]) {
                    str = [self getPirceByRate:[NSString stringWithFormat:@"%f",model.price] balance:balance];
                }
            }
            return str;
        }
        case YYSettingLanguageTypeEnglish:{
            for (RateModel *model in models) {
                if ([model.code isEqualToString:@"USD"]) {
                    str = [self getPirceByRate:[NSString stringWithFormat:@"%f",model.price] balance:balance];
                }
            }
            return str;
        }
        case YYSettingLanguageTypeKorea: {
            for (RateModel *model in models) {
                if ([model.code isEqualToString:@"KRW"]) {
                    str = [self getPirceByRate:[NSString stringWithFormat:@"%f",model.price] balance:balance];
                }
            }
            return str;
        }
        default: {
            for (RateModel *model in models) {
                if ([model.code isEqualToString:@"USD"]) {
                    str = [self getPirceByRate:[NSString stringWithFormat:@"%f",model.price] balance:balance];
                }
            }
            return str;
        }
            break;
    }
    return str;
}

+ (NSString *)getPirceByRate:(NSString *)rate balance:(NSString *)balance {
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:rate];
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:balance];
    NSDecimalNumber *value = [num1 decimalNumberByMultiplyingBy:num2];
    NSString *str = [NSString stringWithFormat:@"%@",value];
    return str;
}

@end
