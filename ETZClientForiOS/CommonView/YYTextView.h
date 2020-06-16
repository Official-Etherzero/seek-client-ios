//
//  YYTextView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;
@property (nonatomic, assign) IBInspectable NSTextAlignment alignment;
@property (nonatomic, strong) UILabel *placeHolderLabel;

-(void)textChanged:(NSNotification*)notification;


@end

NS_ASSUME_NONNULL_END
