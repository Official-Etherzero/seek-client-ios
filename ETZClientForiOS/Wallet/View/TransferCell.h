//
//  TransferCell.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferDetailItem.h"
#import "TransferItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransferCell : UICollectionViewCell

@property (nonatomic, strong) TransferItem  *item;

@end

NS_ASSUME_NONNULL_END
