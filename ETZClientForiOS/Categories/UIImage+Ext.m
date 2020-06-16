#import "UIImage+Ext.h"
#import <GLKit/GLKit.h>
#import <Accelerate/Accelerate.h>
#import "YYWebImage.h"

@implementation UIImage (Ext)

+ (UIImage *)yy_imageRenderOriginalWithName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)yy_imageWithColor:(UIColor *)color {
    return [self yy_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)yy_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)yy_imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)yy_boxBlurImageWithBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int) (blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *) CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if (pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    return returnImage;
}


- (UIImage *)yy_imageByRotateLeft90 {
    return [self yy_imageByRotate:GLKMathDegreesToRadians(90) fitSize:YES];
}

- (UIImage *)yy_imageByRotateRight90 {
    return [self yy_imageByRotate:GLKMathDegreesToRadians(-90) fitSize:YES];
}

- (UIImage *)yy_imageByRotate180 {
    return [self _yy_flipHorizontal:YES vertical:YES];
}

- (UIImage *)yy_imageByFlipVertical {
    return [self _yy_flipHorizontal:NO vertical:YES];
}

- (UIImage *)yy_imageByFlipHorizontal {
    return [self _yy_flipHorizontal:YES vertical:NO];
}

- (UIImage *)yy_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize {
    size_t width = (size_t) CGImageGetWidth(self.CGImage);
    size_t height = (size_t) CGImageGetHeight(self.CGImage);
    CGRect newRect = CGRectApplyAffineTransform(CGRectMake(0., 0., width, height),
            fitSize ? CGAffineTransformMakeRotation(radians) : CGAffineTransformIdentity);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
            (size_t) newRect.size.width,
            (size_t) newRect.size.height,
            8,
            (size_t) newRect.size.width * 4,
            colorSpace,
            kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    if (!context) return nil;

    CGContextSetShouldAntialias(context, true);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);

    CGContextTranslateCTM(context, +(newRect.size.width * 0.5), +(newRect.size.height * 0.5));
    CGContextRotateCTM(context, radians);

    CGContextDrawImage(context, CGRectMake(-(width * 0.5), -(height * 0.5), width, height), self.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imgRef);
    CGContextRelease(context);
    return img;
}

- (UIImage *)_yy_flipHorizontal:(BOOL)horizontal vertical:(BOOL)vertical {
    if (!self.CGImage) return nil;
    size_t width = (size_t) CGImageGetWidth(self.CGImage);
    size_t height = (size_t) CGImageGetHeight(self.CGImage);
    size_t bytesPerRow = width * 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    if (!context) return nil;

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(context);
    if (!data) {
        CGContextRelease(context);
        return nil;
    }
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    if (vertical) {
        vImageVerticalReflect_ARGB8888(&src, &dest, kvImageBackgroundColorFill);
    }
    if (horizontal) {
        vImageHorizontalReflect_ARGB8888(&src, &dest, kvImageBackgroundColorFill);
    }
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imgRef);
    return img;
}

- (UIImage *)yy_imageByCircle {
    return [self yy_imageByRoundCornerRadius:self.size.height * 0.5];
}

- (CGSize)yy_size {
    return self.size;
}

- (CGFloat)yy_height {
    return self.size.height;
}

- (CGFloat)yy_width {
    return self.size.width;
}

- (CGSize)yy_sizeWithMultiplyBy:(CGFloat)scale {
    return CGSizeMake(self.yy_width * scale, self.yy_height * scale);
}

+ (UIImage *)yy_imageWithName:(NSString *)name stretch:(UIEdgeInsets)insets {
    return [[UIImage imageNamed:name] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)yy_imageStretchWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height - 1, 1, 1, image.yy_width - 1) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)clipImage {

    CGRect drawRect = CGRectMake(0, 0, self.size.height, self.size.height);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 2.0);

    //获取路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:drawRect];

    //裁剪圆形
    [path addClip];

    //把图片塞进上下文中
    [self drawInRect:drawRect];

    //保存新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    //关闭上下文
    UIGraphicsEndImageContext();

    //返回图片
    return newImage;

}

@end
