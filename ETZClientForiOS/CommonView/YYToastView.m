//
//  YYToastView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYToastView.h"
#import "YYViewHeader.h"
#import "YYWebImage.h"
#import "NSString+Ext.h"

@implementation YYToastView


+ (instancetype)showAboveWithTitle:(NSString *)title attachedView:(UIView *)attachedView {
    YYToastView *v = [[YYToastView alloc] initTransparentViewWithTitle:title attachedView:attachedView];
    [v show];
    return v;
}

+ (instancetype)showCenterWithTitle:(NSString *)title attachedView:(UIView *)attachedView {
    YYToastView *v = [[YYToastView alloc] initWithTitle:title attachedView:attachedView style:YYToastViewCenter];
    [v show];
    return v;
}

+ (instancetype)showCenterWithTitle:(NSString *)title attachedView:(UIView *)attachedView show:(void(^)(void))showblock {
    YYToastView *v = [[YYToastView alloc] initWithTitle:title attachedView:attachedView style:YYToastViewCenter];
    
    [v showWithBlock:^(YYPopView * _Nonnull popupView) {
        if (showblock) {
            showblock();
        }
    }];
    return v;
}

+ (instancetype)showBelowWithTitle:(NSString *)title attachedView:(UIView *)attachedView {
    YYToastView *v = [[YYToastView alloc] initWithTitle:title attachedView:attachedView style:YYToastViewBelow];
    [v show];
    return v;
}

+ (instancetype)showBelowWithTitle:(NSString *)title attachedView:(UIView *)attachedView hide:(void(^)(void))hideblock {
    YYToastView *v = [[YYToastView alloc] initWithTitle:title attachedView:attachedView style:YYToastViewBelow];
    [v showWithBlock:^(YYPopView *view) {
        if (hideblock) {
            hideblock();
        }
    }];
    return v;
}

- (instancetype)initWithTitle:(NSString *)title attachedView:(UIView *)attachedView {
    return [self initWithTitle:title attachedView:attachedView style:YYToastViewCenter];
}

- (instancetype)initTransparentViewWithTitle:(NSString *)title attachedView:(UIView *)attachedView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.attachedView = attachedView;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = title;
        label.layer.shadowColor = COLOR_808080.CGColor;
        label.textColor = COLOR_ffffff;
        label.font = FONT_DESIGN_36;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(69);
        }];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title attachedView:(UIView *)attachedView style:(YYToastViewStyle)style {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.attachedView = attachedView;
        UIButton *background = ({
            UIButton *v = [[UIButton alloc] initWithFrame:CGRectZero];
            [v setTitle:title forState:UIControlStateNormal];
            v.titleLabel.numberOfLines = 0;
            v.titleLabel.textAlignment = NSTextAlignmentCenter;
            v.titleLabel.font = FONT_DESIGN_28;
            CGSize size = [title yy_sizeForFont:FONT_DESIGN_28];
            UIImage *background = [[YYImage yy_imageWithColor:COLOR_141414 size:CGSizeMake(size.width + 24, size.height + 18)] yy_imageByRoundCornerRadius:8];
            [v setBackgroundImage:background forState:UIControlStateNormal];
            v;
        });
        [self addSubview:background];
        [background sizeToFit];
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (style) {
                case YYToastViewBelow:
                    make.centerX.mas_equalTo(self);
                    make.bottom.mas_equalTo(self).offset(-108.5);
                    break;
                case YYToastViewCenter:
                    make.center.mas_equalTo(self);
                    break;
            }
            
        }];
    }
    return self;
}

- (void)showWithBlock:(void (^)(YYPopView *))block {
    [super showWithBlock:block];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}


@end
