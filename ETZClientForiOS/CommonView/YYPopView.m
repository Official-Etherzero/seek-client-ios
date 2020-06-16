//
//  YYPopView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYPopView.h"
#import "YYViewHeader.h"
#import "YYWebImage.h"

@implementation YYPopView

- (void)showWithBlock:(void (^)(YYPopView *popView))block {
    self.tag = [YYPopView identifier];
    self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
    self.alpha = 0.0f;
    assert(self.attachedView);
    assert(![self.attachedView isKindOfClass:[UIScrollView class]]);
    __weak typeof(self) weakself = self;
    if (self.animationType == YYPopupViewAnimationTypeActionSheet) {
        if (!self.superview) {
            [_attachedView addSubview:self];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(_attachedView);
            }];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
            }];
            [self layoutIfNeeded];
        }
        [UIView animateWithDuration:0.6f
                              delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.bottom.equalTo(self.attachedView.mas_bottom);
                             }];
                             self.layer.transform = CATransform3DIdentity;
                             self.alpha = 1.0f;
                             [self layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             if (block) {
                                 block(weakself);
                             }
                         }];
    } else {
        if (!self.superview) {
            [_attachedView addSubview:self];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(_attachedView);
            }];
            [self layoutIfNeeded];
        }
        [UIView animateWithDuration:0.6f
                              delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.layer.transform = CATransform3DIdentity;
                             self.alpha = 1.0f;
                         }
                         completion:^(BOOL finished) {
                             if (block) {
                                 block(weakself);
                             }
                         }];
    }
    
}

- (void)show {
    [self showWithBlock:nil];
}

- (void)hide {
    [self hideWithBlock:nil];
}

- (void)hideWithBlock:(void (^)(YYPopView *popView))block {
    [UIView animateWithDuration:0.6f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         if (self.animationType == YYPopupViewAnimationTypeActionSheet) {
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
                             }];
                             [self.superview layoutIfNeeded];
                         }
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         if ( finished ) {
                             [self removeFromSuperview];
                         }
                         
                         if ( block) {
                             block(self);
                         }
                     }];
    
}
+ (NSInteger)identifier {
    return 10000;
}


@end
