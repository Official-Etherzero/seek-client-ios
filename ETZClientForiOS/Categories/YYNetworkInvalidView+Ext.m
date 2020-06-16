//
//  YYNetworkInvalidView+Ext.m
//  Video_edit
//
//  Created by yang on 2018/10/16.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYNetworkInvalidView+Ext.h"

@implementation YYNetworkInvalidView (Ext)

+ (instancetype)initWithAttachView:(UIView *)attachView
                           refresh:(RefreshBlock)refresh {
    YYNetworkInvalidView *view = [[YYNetworkInvalidView alloc] initWithAttachView:attachView refresh:refresh];
    return view;
}

@end
