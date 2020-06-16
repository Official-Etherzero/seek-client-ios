//
//  WalletCell.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalletCell : UITableViewCell

@property (nonatomic, strong) AccountModel *model;
@property (nonatomic, assign) BOOL         isSelected;

@end

NS_ASSUME_NONNULL_END
