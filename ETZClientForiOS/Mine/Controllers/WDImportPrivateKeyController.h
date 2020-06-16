//
//  WDImportPrivateKeyController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDImportPrivateKeyController : WDBaseFunctionController

- (instancetype)initWithAccountModel:(AccountModel *)model
                            topTitle:(NSString *)topTitile;

@end

NS_ASSUME_NONNULL_END
