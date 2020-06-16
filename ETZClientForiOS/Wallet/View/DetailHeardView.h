//
//  DetailHeardView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenItem.h"
#import "RateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailHeardView : UIView

@property (nonatomic, strong) TokenItem *item;
@property (nonatomic,   copy) NSArray <RateModel *>* rateModels;

@end

NS_ASSUME_NONNULL_END
