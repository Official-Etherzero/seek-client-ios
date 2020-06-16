//
//  YYCalculateModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/12.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCalculateModel : NSObject

/**
 除以 18 位运算
 */
+ (NSString *)yy_calculateDividedWithNumString:(NSString *)num;

/** 乘以 18位运算*/
+ (NSString *)yy_calculateMultiplyedWithNumString:(NSString *)num;

/** 除以 9 位运算*/
+ (NSString *)yy_calculateDividedByGasPrice:(NSString *)num;

/** 乘以 9 位运算*/
+ (NSString *)yy_calculateMultiplyedByGasPrice:(NSString *)num;

/** 计算矿工费用
 @parm price
 @parm limit
 除以 9
 */

+ (NSString *)yy_calculateMultiplyedWithPrice:(NSString *)price
                                        limit:(NSString *)limit;


/**
 判断当前转出币数以及矿工费用之和是不是小于余额数
 */

+ (BOOL)yy_isCanTradeByBalance:(NSString *)balance
                        amount:(NSString *)amount
                          cost:(NSString *)cost;


@end

NS_ASSUME_NONNULL_END
