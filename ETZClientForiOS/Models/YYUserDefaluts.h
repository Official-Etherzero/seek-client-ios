//
//  YYUserDefaluts.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountModel;
NS_ASSUME_NONNULL_BEGIN

@interface YYUserDefaluts : NSObject

+ (void)yy_setAccountModelIndex:(NSInteger)index;
+ (NSInteger)yy_getAccountModelIndex;
+ (void)yy_updateAccountIndex:(AccountModel *)model;

@end

NS_ASSUME_NONNULL_END
