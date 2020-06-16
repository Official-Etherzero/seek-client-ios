//
//  WDTokenDetailsController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBaseFunctionController.h"

@class TokenItem;
NS_ASSUME_NONNULL_BEGIN

@interface WDTokenDetailsController : WDBaseFunctionController

- (instancetype)initWithTokenItem:(TokenItem *)item;

@end

NS_ASSUME_NONNULL_END
