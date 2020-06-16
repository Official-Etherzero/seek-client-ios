//
//  TokensCell.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/17.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TokensCell : UICollectionViewCell
/** 添加代币*/
@property (nonatomic,   copy) void(^addTokenBlock) (TokenModel *model);
@property (nonatomic, strong) TokenModel  *model;

@end

NS_ASSUME_NONNULL_END
