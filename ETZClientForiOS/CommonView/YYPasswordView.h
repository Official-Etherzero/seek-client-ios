//
//  YYPasswordView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/22.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYPasswordView : UIView

@property (nonatomic,  copy) NSString *content;

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                            plcStr:(NSString *)plcStr;

- (void)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
