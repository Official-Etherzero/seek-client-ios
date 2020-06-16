//
//  YYLabel.h
//  Video_edit
//
//  Created by yang on 2018/9/27.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets textInsets;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

/**
 圆形 1、默认内边距为 3，2、内边距为 0.
 */
- (void)setDefaultTextFrame:(CGFloat)textFontSize point:(CGPoint)point;

- (void)updateLabelTextFrame:(CGFloat)textFontSize point:(CGPoint)point;

/**
 方形 设置内边距为 0；
 */

- (void)setTextInsetsZero:(CGFloat)textFontSize point:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
