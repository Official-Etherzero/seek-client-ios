#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Ext)

+ (UIImage *)yy_imageRenderOriginalWithName:(NSString *)name;

+ (UIImage *)yy_imageWithColor:(UIColor *)color;
+ (UIImage *)yy_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)yy_imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

- (UIImage *)yy_boxBlurImageWithBlurNumber:(CGFloat)blur;

- (UIImage *)yy_imageByRotateLeft90;
- (UIImage *)yy_imageByRotateRight90;
- (UIImage *)yy_imageByRotate180;
- (UIImage *)yy_imageByFlipVertical;
- (UIImage *)yy_imageByFlipHorizontal;

- (UIImage *)yy_imageByCircle;

- (CGSize)yy_size;
- (CGFloat)yy_height;
- (CGFloat)yy_width;
- (CGSize)yy_sizeWithMultiplyBy:(CGFloat)scale;

- (UIImage *)clipImage;

+ (UIImage *)yy_imageWithName:(NSString *)name stretch:(UIEdgeInsets)insets;

+ (UIImage *)yy_imageStretchWithName:(NSString *)name;

@end
