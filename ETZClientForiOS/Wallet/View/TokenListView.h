//
//  TokenListView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
#import "TokenItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TokenListViewDelegate <NSObject>

- (void)yy_openAddTokenViewController;

- (void)yy_openTokenDetailsViewControllerWithItem:(TokenItem *)item;


@end

@interface TokenListView : UIView

@property (nonatomic, assign) id<TokenListViewDelegate>delegate;
@property (nonatomic, strong) AccountModel *model;

@end

NS_ASSUME_NONNULL_END
