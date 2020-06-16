//
//  TokenList.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/17.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenModel.h"
#import "YYErrorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TokenList : NSObject

@property (nonatomic, strong) NSMutableArray<TokenModel *>  *tokenList;
@property (nonatomic, strong) YYErrorModel                  *errorModel;

+ (NSArray<TokenModel *> *)getCacheTokenList;

@end

NS_ASSUME_NONNULL_END
