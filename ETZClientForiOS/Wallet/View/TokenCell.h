//
//  TokenCell.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TokenCell : UICollectionViewCell

@property (nonatomic, strong) TokenItem *item;

@end

NS_ASSUME_NONNULL_END
