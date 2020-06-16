//
//  TransferDetailItem.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YYTransferStatus){
    YYTransferIng       = 0,
    YYTransferSuccess   = 1,
    YYTransferFailure   = 2,
};

typedef NS_ENUM(NSInteger,YYTransferType){
    YYTransferPay          = 0,
    YYTransferCollection   = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface TransferDetailItem : NSObject

@property (nonatomic,   copy) NSString          *transAddress;
@property (nonatomic, assign) double            coinNum;
@property (nonatomic, strong) NSDate            *date;
@property (nonatomic, assign) YYTransferType    type;
@property (nonatomic, assign) YYTransferStatus  status;

@end

NS_ASSUME_NONNULL_END
