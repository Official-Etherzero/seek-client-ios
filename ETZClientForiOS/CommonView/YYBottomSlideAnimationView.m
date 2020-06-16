//
//  YYBottomSlideAnimationView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYBottomSlideAnimationView.h"
#import "MSSPopMasonry.h"

@implementation YYBottomSlideAnimationView
{
    POPBasicAnimation *_displayAnimation;
    POPBasicAnimation *_hideAnimation;
}

- (instancetype)initWithSuperview:(UIView *)superview
                              top:(UIView *)top {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _superview = superview;
        _top = top;
        assert(_superview != nil);
        assert(_top != nil);
        [_superview addSubview:self];
        [_superview sendSubviewToBack:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([self hiddenWhenInit]) {
                _bottomOffset = make.bottom.mas_equalTo(_top.mas_top).offset([self layoutOffset]);
                self.hidden = YES;
            } else {
                _bottomOffset = make.bottom.mas_equalTo(_top.mas_top).offset(0);
                self.hidden = NO;
            }
            make.trailing.leading.mas_equalTo(_superview);
            //  设置一个范围
            //            make.left.mas_equalTo(_superview.mas_left).offset(EVOSIZE_60);
            //            make.right.mas_equalTo(_superview.mas_right).offset(-EVOSIZE_60);
            make.height.mas_equalTo([self layoutHeight]);
        }];
    }
    return self;
}

- (instancetype)initWithSuperview:(UIView *)superview {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _superview = superview;
        _top = superview;
        assert(_superview != nil);
        assert(_top != nil);
        [_superview addSubview:self];
        [_superview sendSubviewToBack:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([self hiddenWhenInit]) {
                _bottomOffset = make.bottom.mas_equalTo(_top).offset([self layoutOffset]);
                self.hidden = YES;
            } else {
                _bottomOffset = make.bottom.mas_equalTo(_top).offset(0);
                self.hidden = NO;
            }
            make.trailing.leading.mas_equalTo(_superview);
            make.height.mas_equalTo([self layoutHeight]);
        }];
    }
    return self;
}

#pragma mark -public
- (void)display {
    [self displayWithComplete:nil];
}

- (void)displayWithComplete:(void(^)(BOOL complete))completion {
    assert(_superview != nil);
    assert(_top != nil);
    self.hidden = NO;
    [self setUserInteractionEnabled:YES];
    _displayAnimation.paused = YES;
    [_bottomOffset pop_removeAnimationForKey:@"offset"];
    _displayAnimation = [POPBasicAnimation defaultAnimation];
    _displayAnimation.duration = 0.25;
    _displayAnimation.toValue = @(0);
    _displayAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (completion) {
            completion(finished);
        }
    };
    _displayAnimation.property = [POPAnimatableProperty mas_offsetProperty];
    [_bottomOffset pop_addAnimation:_displayAnimation forKey:@"offset"];
}

- (void)hide {
    [self hideWithComplete:nil];
}

- (void)hideWithComplete:(void(^)(BOOL complete))completion {
    assert(_superview != nil);
    assert(_top != nil);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setUserInteractionEnabled:NO];
    });
    __weak typeof(self) weakself = self;
    _hideAnimation.paused = YES;
    [_bottomOffset pop_removeAnimationForKey:@"offset"];
    _hideAnimation = [POPBasicAnimation defaultAnimation];
    _hideAnimation.duration = 0.25;
    _hideAnimation.toValue = @([self layoutOffset] + [self layoutOffset]/2);
    _hideAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        weakself.hidden = YES;
        if (completion) {
            completion(finished);
        }
    };
    _hideAnimation.property = [POPAnimatableProperty mas_offsetProperty];
    [_bottomOffset pop_addAnimation:_hideAnimation forKey:@"offset"];
}

- (BOOL)hiddenWhenInit {
    return YES;
}

- (CGFloat)layoutOffset {
    return 0;
}

- (CGFloat)layoutHeight {
    return 0;
}


@end
