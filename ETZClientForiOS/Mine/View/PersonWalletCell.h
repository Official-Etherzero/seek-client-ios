//
//  PersonWalletCell.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonWalletCell : UITableViewCell

@property (nonatomic, strong) AccountModel *model;
@property (nonatomic,   copy) NSString     *balance;

@end

NS_ASSUME_NONNULL_END
