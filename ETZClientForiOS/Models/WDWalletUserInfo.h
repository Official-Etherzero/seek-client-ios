//
//  WDWalletUserInfo.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Realm/Realm.h>
#import "AccountModel.h"

/** SEEK WALLET*/
NS_ASSUME_NONNULL_BEGIN

@interface WDWalletUserInfo : RLMObject

@property (nonatomic,  copy) NSString *address;
@property (nonatomic,  copy) NSString *keyStore;
@property (nonatomic,  copy) NSString *mnemonicPhrase;
@property (nonatomic,  copy) NSString *privateKey;
@property (nonatomic,  copy) NSString *password;
@property (nonatomic,  copy) NSString *userName;
@property (nonatomic,  copy) NSString *decimal;
@property (nonatomic,strong) NSDate   *date;

+ (void)addAccount:(AccountModel *)model;

+ (void)removeAccount:(AccountModel *)model;

+ (void)updateAccount:(AccountModel *)model;

@end

NS_ASSUME_NONNULL_END
