//
//  YYPageView.h
//  Video_edit
//
//  Created by yang on 2018/11/1.
//  Copyright © 2018 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYPageView;

@protocol YYPageViewDelegate<NSObject>
- (void)pageViewDidChangeIndex:(YYPageView *)pageView;

@end

@interface YYPageView : UIView

@property(nonatomic,   weak) id <YYPageViewDelegate> delegate;
@property(nonatomic, assign) NSInteger index;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

// 设置 slider 显示状态
- (void)setSliderHiddenStatus:(BOOL)isHidden;

// 隐藏红点
- (void)setRedViewHidden;

- (void)setRedViewHiddenStatusWithIndex:(NSInteger)index isHidden:(BOOL)isHidden;

@end

NS_ASSUME_NONNULL_END
