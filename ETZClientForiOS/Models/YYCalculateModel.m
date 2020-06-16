//
//  YYCalculateModel.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/12.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYCalculateModel.h"

@implementation YYCalculateModel

+ (NSString *)yy_calculateDividedWithNumString:(NSString *)num {
    if (!num) {
        return @"0";
    }
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:num];
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"10e17"];
    NSDecimalNumber *value = [num1 decimalNumberByDividingBy:num2];
    NSString *str = [NSString stringWithFormat:@"%@",value];
    return str;
}

+ (NSString *)yy_calculateMultiplyedWithNumString:(NSString *)num {
    if (!num) {
        return @"0";
    }
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:num];
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"10e17"];
    NSDecimalNumber *value = [num1 decimalNumberByMultiplyingBy:num2];
    NSString *str = [NSString stringWithFormat:@"%@",value];
    return str;
}

/** 除以 9 位运算*/
+ (NSString *)yy_calculateDividedByGasPrice:(NSString *)num {
    if (!num) {
        return @"0";
    }
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:num];
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"10e8"];
    NSDecimalNumber *value = [num1 decimalNumberByDividingBy:num2];
    NSString *str = [NSString stringWithFormat:@"%@",value];
    return str;
}

/** 乘以 9 位运算*/
+ (NSString *)yy_calculateMultiplyedByGasPrice:(NSString *)num {
    if (!num) {
        return @"0";
    }
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:num];
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"10e8"];
    NSDecimalNumber *value = [num1 decimalNumberByMultiplyingBy:num2];
    NSString *str = [NSString stringWithFormat:@"%@",value];
    return str;
}

+ (NSString *)yy_calculateMultiplyedWithPrice:(NSString *)price
                                        limit:(NSString *)limit {
    if (!price || !limit) {
        return @"0";
    }
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:price];
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:limit];
    NSDecimalNumber *total = [num1 decimalNumberByMultiplyingBy:num2];
    NSDecimalNumber *num3 = [[NSDecimalNumber alloc] initWithString:@"10e8"];
    NSDecimalNumber *value = [total decimalNumberByDividingBy:num3];
    NSString *str = [NSString stringWithFormat:@"%@",value];
    return str;
}

+ (BOOL)yy_isCanTradeByBalance:(NSString *)balance
                        amount:(NSString *)amount
                          cost:(NSString *)cost {
    NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:balance]; // 余额
    NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:amount];
    NSDecimalNumber *num3 = [[NSDecimalNumber alloc] initWithString:cost];
    
    NSDecimalNumber *value = [num2 decimalNumberByAdding:num3]; // 交易+矿工费用
    
    //比较
    if ([num1 compare:value] ==  NSOrderedAscending) { //升序
        //num1 < value
        return NO;
    }else if ([num1 compare:value] ==  NSOrderedDescending) { //降序
        //num1 > value
        return YES;
    }else if ([num1 compare:value] ==  NSOrderedSame) {
        //num1 = value
        return YES;
    }
    return NO;
}

@end
