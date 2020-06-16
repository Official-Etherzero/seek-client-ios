#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Ext)


+ (UIColor *)yy_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

+ (UIColor *)yy_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

+ (UIColor *)yy_colorWithHexString:(NSString *)hexString NS_SWIFT_NAME(yy_color(hexString:));

+ (UIColor *)yy_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
