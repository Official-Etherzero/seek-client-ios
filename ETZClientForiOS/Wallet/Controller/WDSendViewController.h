//
//  WDSendViewController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/8.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSModel;
typedef void(^TransationHashCallback)(NSString * _Nonnull hashString);
NS_ASSUME_NONNULL_BEGIN

@interface WDSendViewController : UIViewController

@property (nonatomic,   copy) TransationHashCallback  hashCallback;

- (instancetype)initWithJsModel:(JSModel *)model;

- (instancetype)initWithTransferToAddress:(NSString *)toAddress
                                 gasPrice:(NSString *)gasPrice
                                 gasLimit:(NSString *)gasLimit
                           transferAmount:(NSString *)transferAmount
                                     cost:(NSString *)cost;

@end

NS_ASSUME_NONNULL_END
