//
//  YYNetworkInvalidView.h
//  Video_edit
//
//  Created by yang on 2018/9/25.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYNetworkInvalidViewDelegate <NSObject>

- (void)networkInvalidViewRefreshDidClick;

@end

typedef void(^RefreshBlock)(void);
@interface YYNetworkInvalidView : UIView

@property (nonatomic,  weak)id<YYNetworkInvalidViewDelegate>delegate;

- (instancetype)initWithAttachView:(UIView *)attachView
                           refresh:(RefreshBlock)refresh;

@end

NS_ASSUME_NONNULL_END
