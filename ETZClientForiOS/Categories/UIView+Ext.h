#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Ext)

@property (nonatomic, strong)UIViewController *parentController;

+ (UIWindow *)yy_appWindow;

- (void)yy_removeAllSubviews;

- (CGFloat)yy_x;

- (void)setYy_x:(CGFloat)yy_x;

- (CGFloat)yy_right;

- (void)setYy_right:(CGFloat)yy_right;

- (CGFloat)yy_top;

- (void)setYy_top:(CGFloat)yy_top;

- (CGFloat)yy_bottom;

- (void)setYy_bottom:(CGFloat)yy_bottom;

- (CGFloat)yy_width;

- (void)setYy_width:(CGFloat)yy_width;

- (CGFloat)yy_height;

- (void)setYy_height:(CGFloat)yy_height;

- (CGFloat)yy_centerX;

- (void)setYy_centerX:(CGFloat)yy_centerX;

- (CGFloat)yy_centerY;

- (void)setYy_centerY:(CGFloat)yy_centerY;

- (CGPoint)yy_origin;

- (void)setYy_origin:(CGPoint)yy_origin;

- (CGSize)yy_size;

- (void)setYy_size:(CGSize)yy_size;

- (void)yy_rotationWithOrietation:(UIDeviceOrientation)orientation;
- (void)yy_rotationNoAnimateWithOrietation:(UIDeviceOrientation)orientation;


- (CGRect)yy_frameMultiByScale:(CGFloat)scale;

- (UIViewController *)currentViewController;

@end
