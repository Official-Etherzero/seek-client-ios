//
//  YYNetworkInvalidView+Ext.h
//  Video_edit
//
//  Created by yang on 2018/10/16.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYNetworkInvalidView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkInvalidView (Ext)

+ (instancetype)initWithAttachView:(UIView *)attachView
                           refresh:(RefreshBlock)refresh;


@end

NS_ASSUME_NONNULL_END
