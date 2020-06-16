//
//  WalletHeaderView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@class WalletHeaderView;
NS_ASSUME_NONNULL_BEGIN

@protocol WalletHeaderViewDelegate  <NSObject>

- (void)yy_openWalletListViewControler;
- (void)yy_functionClickWithCurrentIndex:(NSUInteger)index;

@end

@interface WalletHeaderView : UIView

@property (nonatomic, assign) id<WalletHeaderViewDelegate>delegate;
@property (nonatomic, strong) AccountModel  *model;

@end

NS_ASSUME_NONNULL_END
