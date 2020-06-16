//
//  YYPopView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, YYPopupViewAnimationType) {
    YYPopupViewAnimationTypeDefault,
    YYPopupViewAnimationTypeActionSheet
};

NS_ASSUME_NONNULL_BEGIN

@interface YYPopView : UIView

@property(nonatomic,   weak)UIView *attachedView;
@property(nonatomic, assign)YYPopupViewAnimationType animationType;

- (void)showWithBlock:(void (^)(YYPopView *popupView))block;
- (void)show;
- (void)hide;
- (void)hideWithBlock:(void (^)(YYPopView *popupView))block;
+ (NSInteger)identifier;



@end

NS_ASSUME_NONNULL_END
