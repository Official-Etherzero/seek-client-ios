//
//  YYLoadingView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYLoadingView.h"
#import "YYViewHeader.h"
#import "YYImageBundle.h"
#import "YYWebImage.h"

@interface YYLoadingView ()

@property (nonatomic, strong) YYAnimatedImageView *loadingView;

@end


@implementation YYLoadingView

- (instancetype)initAboveView:(UIView *)attachView {
    if (self = [super init]) {
        [self initSubView:attachView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-YYSIZE_100);
        }];
    }
    return self;
}

- (instancetype)initAttachView:(UIView *)attachView {
    if (self = [super init]) {
        [self initSubView:attachView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

- (instancetype)initBelowView:(UIView *)attachView {
    if (self = [super init]) {
        [self initSubView:attachView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(YYSIZE_100);
        }];
    }
    return self;
}

- (instancetype)initBottomView:(UIView *)attachView {
    if (self = [super init]) {
        [self initSubView:attachView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(YYSIZE_182);
        }];
    }
    return self;
}

- (void)initSubView:(UIView *)attachView {
    self.backgroundColor = [UIColor clearColor];
    [attachView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(attachView);
    }];
    NSArray *imagePaths = [YYImageBundle loadingAnimation];
    YYFrameImage *frameImage = [[YYFrameImage alloc] initWithImagePaths:imagePaths oneFrameDuration:0.15 loopCount:0];
    YYAnimatedImageView *loadingView = [[YYAnimatedImageView alloc] initWithImage:frameImage];
    self.loadingView = loadingView;
    [self addSubview:loadingView];
}

- (void)hide {
    [self removeFromSuperview];
    __weak __typeof(&*self)weakSelf = self;
    weakSelf = nil;
}


@end
