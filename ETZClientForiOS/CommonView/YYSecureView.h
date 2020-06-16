//
//  YYSecureView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYSecureView : YYTextView

/** 单元格控制在 6 ~ 12 个 */
@property (nonatomic, assign) IBInspectable NSUInteger inputUnitCount;
@property (nonatomic, assign) IBInspectable CGFloat    unitSpace;
@property (nonatomic, assign) IBInspectable BOOL autoResignFirstResponderWhenInputFinished; // 是否取消第一响应
// 用于提示输入的焦点所在位置，设置该值后会产生一个光标闪烁动画，如果设置为空，则不生成光标动画。
@property (nullable, nonatomic, strong) IBInspectable UIColor *cursorColor;
// 设置文本字体
@property (nonatomic, strong) IBInspectable UIFont *textFont;
// 设置文本颜色，默认为黑色。
@property (nullable, nonatomic, strong) IBInspectable UIColor *textColor;
@property (nullable, nonatomic, strong) IBInspectable UIColor *tintColor;
/** 密文输入,默认值为 NO. */
@property (nonatomic, assign, getter=isSecureTextEntry) IBInspectable BOOL secureTextEntry;

@property (nonatomic,    copy) NSString *secureContent;

@end

NS_ASSUME_NONNULL_END
