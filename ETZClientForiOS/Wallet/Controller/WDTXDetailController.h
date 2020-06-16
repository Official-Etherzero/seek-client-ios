//
//  WDTXDetailController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/12/4.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "TransferItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDTXDetailController : WDBaseFunctionController

- (instancetype)initWithTransferItem:(TransferItem *)item;

@end

NS_ASSUME_NONNULL_END
