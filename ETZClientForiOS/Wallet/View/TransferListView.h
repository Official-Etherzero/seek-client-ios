//
//  TransferListView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransferItem;
NS_ASSUME_NONNULL_BEGIN

@protocol TransferListViewDelegate  <NSObject>

- (void)yy_openTransferDetailControllerWithItem:(TransferItem *)item;

@end

@interface TransferListView : UIView

@property (nonatomic, assign) id<TransferListViewDelegate>delegate;
@property (nonatomic, strong) NSArray<TransferItem *> * items;

@end

NS_ASSUME_NONNULL_END
