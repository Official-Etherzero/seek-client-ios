//
//  TransferBottomView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TransferBottomViewDelegate <NSObject>

- (void)yy_openTransferController;

- (void)yy_openCollectionController;

@end

@interface TransferBottomView : UIView

@property (nonatomic, assign) id<TransferBottomViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
