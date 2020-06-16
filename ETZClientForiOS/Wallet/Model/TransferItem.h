//
//  TransferItem.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/7.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransferItem : NSObject

@property (nonatomic, assign) long       __v;
@property (nonatomic,   copy) NSString   *blockHash;
@property (nonatomic,   copy) NSString   *blockNumber;
@property (nonatomic,   copy) NSString   *confirmations;
@property (nonatomic,   copy) NSString   *contractAddress;
@property (nonatomic,   copy) NSString   *from;
@property (nonatomic,   copy) NSString   *gas;
@property (nonatomic,   copy) NSString   *gasPrice;
@property (nonatomic,   copy) NSString   *gasUsed;
@property (nonatomic,   copy) NSString   *hash;
@property (nonatomic,   copy) NSString   *input;
@property (nonatomic,   copy) NSString   *isError;
@property (nonatomic,   copy) NSString   *miner;
@property (nonatomic,   copy) NSString   *nonce;
@property (nonatomic,   copy) NSString   *status;
@property (nonatomic,   copy) NSString   *timeStamp;
@property (nonatomic, assign) long       timestamp;
@property (nonatomic,   copy) NSString   *to;
@property (nonatomic,   copy) NSString   *transactionIndex;
@property (nonatomic,   copy) NSString   *value;

@end

NS_ASSUME_NONNULL_END
