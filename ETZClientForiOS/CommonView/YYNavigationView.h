//
//  YYNavigationView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYNavigationView;

@protocol YYNavigationViewDelegate <NSObject>

@optional
- (void)yyNavigationViewCancelClick:(YYNavigationView *)view;
- (void)yyNavigationViewConfirmClick:(YYNavigationView *)view;
- (void)yyNavigationViewReturnClick:(YYNavigationView *)view;

@end


@interface YYNavigationView : NSObject

@property(nonatomic, weak) id<YYNavigationViewDelegate> delegate;
@property(nonatomic, strong, readonly) UIButton *saveButton;


- (instancetype)initWithNavigationItem:(UINavigationItem *)item;

- (void)confirm;

- (void)returnButton;

- (void)customReturnButton;

- (void)dismiss;

- (void)setReturnButtonEnable:(BOOL)isEnable;

- (void)adapterNavigationBar;

@end

NS_ASSUME_NONNULL_END
