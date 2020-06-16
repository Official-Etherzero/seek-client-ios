#import "UIView+Ext.h"
#import <GLKit/GLKit.h>

@implementation UIView (Ext)

+ (UIWindow *)yy_appWindow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow) {
        keyWindow = [UIApplication sharedApplication].windows[0];
    }
    return keyWindow;
}

- (void)yy_removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (CGFloat)yy_x {
    return self.frame.origin.x;
}

- (void)setYy_x:(CGFloat)yy_x {
    CGRect rect = self.frame;
    rect.origin.x = yy_x;
    self.frame = rect;
}

- (CGFloat)yy_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYy_right:(CGFloat)yy_right {
    CGRect rect = self.frame;
    rect.origin.x = yy_right - self.frame.size.width;
    self.frame = rect;
}

- (CGFloat)yy_top {
    return self.frame.origin.y;
}

- (void)setYy_top:(CGFloat)yy_top {
    CGRect rect = self.frame;
    rect.origin.y = yy_top;
    self.frame = rect;
}

- (CGFloat)yy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYy_bottom:(CGFloat)yy_bottom {
    CGRect rect = self.frame;
    rect.origin.y = yy_bottom - self.frame.size.height;
    self.frame = rect;
}

- (CGFloat)yy_width {
    return self.frame.size.width;
}

- (void)setYy_width:(CGFloat)yy_width {
    CGRect rect = self.frame;
    rect.size.width = yy_width;
    self.frame = rect;
}

- (CGFloat)yy_height {
    return self.frame.size.height;
}

- (void)setYy_height:(CGFloat)yy_height {
    CGRect rect = self.frame;
    rect.size.height = yy_height;
    self.frame = rect;
}

- (CGFloat)yy_centerX {
    return self.center.x;
}

- (void)setYy_centerX:(CGFloat)yy_centerX {
    self.center = CGPointMake(yy_centerX, self.center.y);
}

- (CGFloat)yy_centerY {
    return self.center.y;
}

- (void)setYy_centerY:(CGFloat)yy_centerY {
    self.center = CGPointMake(self.center.x, yy_centerY);
}

- (CGPoint)yy_origin {
    return self.frame.origin;
}

- (void)setYy_origin:(CGPoint)yy_origin {
    CGRect rect = self.frame;
    rect.origin = yy_origin;
    self.frame = rect;
}

- (CGSize)yy_size {
    return self.frame.size;
}

- (void)setYy_size:(CGSize)yy_size {
    CGRect rect = self.frame;
    rect.size = yy_size;
    self.frame = rect;
}

- (void)yy_rotationWithOrietation:(UIDeviceOrientation)orientation {
    [UIView animateWithDuration:0.3f animations:^{
        switch (orientation) {
            case UIDeviceOrientationPortrait: {
                self.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
            }
                break;
            case UIDeviceOrientationPortraitUpsideDown: {
                self.layer.transform = CATransform3DMakeRotation(GLKMathDegreesToRadians(180), 0, 0, 1);
            }
                break;
            case UIDeviceOrientationLandscapeLeft: {
                self.layer.transform = CATransform3DMakeRotation(GLKMathDegreesToRadians(90), 0, 0, 1);
            }
                break;
            case UIDeviceOrientationLandscapeRight: {
                self.layer.transform = CATransform3DMakeRotation(GLKMathDegreesToRadians(-90), 0, 0, 1);
                break;
            }
            default:
                break;
        }
    }];
}

- (void)yy_rotationNoAnimateWithOrietation:(UIDeviceOrientation)orientation {
    switch (orientation) {
        case UIDeviceOrientationPortrait: {
            self.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown: {
            self.layer.transform = CATransform3DMakeRotation(GLKMathDegreesToRadians(180), 0, 0, 1);
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            self.layer.transform = CATransform3DMakeRotation(GLKMathDegreesToRadians(90), 0, 0, 1);
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            self.layer.transform = CATransform3DMakeRotation(GLKMathDegreesToRadians(-90), 0, 0, 1);
            break;
        }
        default:
            break;
    }
}

- (CGRect)yy_frameMultiByScale:(CGFloat)scale {
    CGRect frame = self.frame;
    CGFloat x = frame.origin.x - frame.size.width * scale;
    CGFloat y = frame.origin.y - frame.size.height * scale;
    CGFloat width = frame.size.width * scale * 2;
    CGFloat height = frame.size.height * scale * 2;
    return CGRectMake(x, y, width, height);
}

#pragma mark - handle top viewController

- (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = secondView.parentController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        }
        else {
            return tab.selectedViewController;
        }
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        if ([[nav.viewControllers lastObject] isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)[nav.viewControllers lastObject];
            if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
                return [nav.viewControllers lastObject];
            }
            else {
                return tab.selectedViewController;
            }
        }
        else {
            return [nav.viewControllers lastObject];
        }
    }
    else {
        return vc;
    }
    return nil;
}

- (UIViewController *)parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end
