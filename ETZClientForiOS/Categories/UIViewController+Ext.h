//
//  UIViewController+Ext.h
//  XXClientForiOS
//
//  Created by yang on 2018/10/22.
//  Copyright © 2018年 yang123. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Ext)

- (BOOL)yy_isVisible;

- (void)yy_hideTabBar:(BOOL)hidden;

- (UIInterfaceOrientationMask)yy_interfaceOrientationMask;

- (void)yy_interfaceOrientation:(UIInterfaceOrientation)orientation supportOrientationMask:(UIInterfaceOrientationMask)mask;

- (void)yy_interfaceSupportOrientationMask:(UIInterfaceOrientationMask)mask;

- (void)yy_interfaceSupportOrientationMaskLock;

- (UIInterfaceOrientation)yy_interfaceOrientation;

- (UIInterfaceOrientation)yy_getCurrentOrientation;

@end

NS_ASSUME_NONNULL_END
