//
//  YYBottomSlideAnimationView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBottomSlideAnimationView : UIView{
@protected
    __weak UIView *_superview;
    __weak UIView *_top;
    MASConstraint *_bottomOffset;
}

@property(nonatomic, assign) CGFloat customeLayoutOffset;
- (instancetype)initWithSuperview:(UIView *)superview top:(UIView *)top;
- (instancetype)initWithSuperview:(UIView *)superview;

- (CGFloat)layoutOffset;
- (CGFloat)layoutHeight;
- (BOOL)hiddenWhenInit;

- (void)display;
- (void)displayWithComplete:(void(^)(BOOL complete))completion;
- (void)hide;
- (void)hideWithComplete:(void(^)(BOOL complete))completion;


@end

NS_ASSUME_NONNULL_END
