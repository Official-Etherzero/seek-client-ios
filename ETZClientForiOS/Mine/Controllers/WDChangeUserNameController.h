//
//  WDChangeUserNameController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/11/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ExitChangeUserNameCallback)(AccountModel *model);

@interface WDChangeUserNameController : UIViewController

@property(nonatomic, copy) ExitChangeUserNameCallback exitCallback;

- (instancetype)initWithAccount:(AccountModel *)model;

@end

NS_ASSUME_NONNULL_END
