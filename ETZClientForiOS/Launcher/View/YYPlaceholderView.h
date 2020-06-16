//
//  YYPlaceholderView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYPlaceholderView : UIView 

/**
 @parm content     textView 输入框内容
 @parm desString   外部赋值内容
 */
@property (nonatomic,  copy) NSString *content;
@property (nonatomic,  copy) NSString *desString;

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                            plcStr:(NSString *)plcStr;

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                           content:(NSString *)content;

- (void)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
