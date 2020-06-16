//
//  MinerModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/18.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MinerModel : NSObject

@property (nonatomic, assign) long       __v;
@property (nonatomic,   copy) NSString   *_id;
@property (nonatomic,   copy) NSString   *address;
@property (nonatomic,   copy) NSString   *author;
@property (nonatomic, assign) long       avgReward;
@property (nonatomic, assign) long       blockCount;
@property (nonatomic,   copy) NSString   *blockHash;
@property (nonatomic, assign) long       blockNumber;
@property (nonatomic, assign) long       burntCoin;
@property (nonatomic,   copy) NSString   *inviter;
@property (nonatomic, assign) long       level;
@property (nonatomic, assign) long       maxStorage;
@property (nonatomic, assign) long       rate;
@property (nonatomic, assign) long       refundRate;
@property (nonatomic, assign) long       registTime;
@property (nonatomic, assign) long       reward;
@property (nonatomic, assign) long       setAuthorBlock;
@property (nonatomic, assign) long       timestamp;
@property (nonatomic, assign) long       updateAt;
@property (nonatomic,   copy) NSString   *version;

@end

NS_ASSUME_NONNULL_END
