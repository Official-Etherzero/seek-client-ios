//
//  WDMnemonicController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBaseFunctionController.h"
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDMnemonicController : WDBaseFunctionController

- (instancetype)initWithAccountModel:(AccountModel *)model;

@end

NS_ASSUME_NONNULL_END
