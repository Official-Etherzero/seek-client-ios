//
//  YYLoadingView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYLoadingView : UIView

- (instancetype)initAboveView:(UIView *)attachView;

- (instancetype)initAttachView:(UIView *)attachView;

- (instancetype)initBelowView:(UIView *)attachView;

- (instancetype)initBottomView:(UIView *)attachView;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
