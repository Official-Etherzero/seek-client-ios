//
//  YYAlertView.h
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmBlock)(void);
typedef void(^cancelBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface YYAlertView : UIView

- (instancetype)initWithAttachView:(UIView *)attachView
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                       cancelTitle:(NSString *)cancelTitle
                           confirm:(confirmBlock)confirm
                            cancel:(cancelBlock)cancel;

@end

NS_ASSUME_NONNULL_END
