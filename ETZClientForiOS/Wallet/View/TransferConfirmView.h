//
//  TransferConfirmView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYPlaceholderView.h"
#import "YYPasswordView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TransferConfirmViewDelegate <NSObject>

- (void)yy_confirmPayClickAction;

- (void)yy_returnPayDetailView;

@end

@interface TransferConfirmView : UIView

@property (nonatomic, assign) id<TransferConfirmViewDelegate> delegate;
@property (nonatomic, strong) YYPasswordView                  *inputPawView;

- (void)setConfirButtonEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
