//
//  PersonalWalletHeaderView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalWalletHeaderView : UIView

- (instancetype)initWithAddress:(NSString *)address
                         amount:(NSString *)amount;

@end

NS_ASSUME_NONNULL_END
