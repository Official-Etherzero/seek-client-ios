//
//  UIViewController+Ext.m
//  XXClientForiOS
//
//  Created by yang on 2018/10/22.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "UIViewController+Ext.h"
#import "AppDelegate.h"
#import "RDVTabBarController.h"

@implementation UIViewController (Ext)

- (void)yy_interfaceOrientation:(UIInterfaceOrientation)orientation supportOrientationMask:(UIInterfaceOrientationMask)mask {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.supportRotation = mask;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)yy_interfaceSupportOrientationMask:(UIInterfaceOrientationMask)mask {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.supportRotation = mask;
}

- (UIInterfaceOrientationMask)yy_interfaceOrientationMask {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.supportRotation;
}

- (void)yy_hideTabBar:(BOOL)hidden {
    [[self rdv_tabBarController] setTabBarHidden:hidden animated:NO];
}

- (BOOL)yy_isVisible {
    return self.isViewLoaded && self.view.window;
}

- (void)yy_interfaceSupportOrientationMaskLock {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationPortrait:
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            break;
        case UIDeviceOrientationLandscapeLeft:
            break;
        case UIDeviceOrientationLandscapeRight:
            break;
        case UIDeviceOrientationFaceUp:
            break;
            
        default:
            break;
    }
    
    [self yy_interfaceSupportOrientationMask:[self yy_interfaceOrientationMask]];
}

- (UIInterfaceOrientation)yy_interfaceOrientation {
    return [[UIApplication sharedApplication] statusBarOrientation];
}

- (UIInterfaceOrientation)yy_getCurrentOrientation {
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        orientation = UIInterfaceOrientationLandscapeRight;
    }else if (deviceOrientation == UIDeviceOrientationLandscapeRight) {
        orientation = UIInterfaceOrientationLandscapeLeft;
    }else {
        orientation = UIInterfaceOrientationPortrait;
    }
    return orientation;
}

@end
