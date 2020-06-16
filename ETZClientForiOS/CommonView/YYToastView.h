//
//  YYToastView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYPopView.h"

typedef NS_ENUM(NSInteger,YYToastViewStyle) {
    YYToastViewCenter,
    YYToastViewBelow
};

NS_ASSUME_NONNULL_BEGIN

@interface YYToastView : YYPopView

+ (instancetype)showAboveWithTitle:(NSString *)title attachedView:(UIView *)attachedView;
+ (instancetype)showCenterWithTitle:(NSString *)title attachedView:(UIView *)attachedView;
+ (instancetype)showCenterWithTitle:(NSString *)title attachedView:(UIView *)attachedView show:(void(^)(void))showblock;
+ (instancetype)showBelowWithTitle:(NSString *)title attachedView:(UIView *)attachedView;
+ (instancetype)showBelowWithTitle:(NSString *)title attachedView:(UIView *)attachedView hide:(void(^)(void))hideblock;

- (instancetype)initWithTitle:(NSString *)title attachedView:(UIView *)attachedView;
- (instancetype)initWithTitle:(NSString *)title attachedView:(UIView *)attachedView style:(YYToastViewStyle)style;


@end

NS_ASSUME_NONNULL_END
