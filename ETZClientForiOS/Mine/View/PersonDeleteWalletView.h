//
//  PersonDeleteWalletView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/10.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonDeleteWalletView : UIView

@property (nonatomic,  copy) void(^confirmDeleteBlock)(void);

@end

NS_ASSUME_NONNULL_END
