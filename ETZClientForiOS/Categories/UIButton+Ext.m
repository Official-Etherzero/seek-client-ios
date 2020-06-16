#import "UIButton+Ext.h"
#import <BlocksKit/BlocksKit.h>
#import <objc/runtime.h>
#import "NSString+Ext.h"

static void *kBottomButtonAndImageWithSpacing = &kBottomButtonAndImageWithSpacing;
static void *kCenterButtonAndImageWithSpacing = &kCenterButtonAndImageWithSpacing;

@implementation UIButton (Ext)

- (void)yy_centerButtonAndImageWithSpacing:(CGFloat)spacing {
    BOOL spacingIfNeed = NO;
    [[self bk_associatedValueForKey:kCenterButtonAndImageWithSpacing] getValue:&spacingIfNeed];
    if (!spacingIfNeed) {
        CGFloat insetAmount = spacing / 2.0;
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, MAX(-insetAmount, 0), 0, insetAmount);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    }
}

- (void)yy_topButtonAndImageWithSpacing:(CGFloat)spacing {
    CGFloat insetAmount = spacing / 2.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(insetAmount,0 , -insetAmount,0);
    self.titleEdgeInsets = UIEdgeInsetsMake(-insetAmount,0 , insetAmount,0);
}

- (void)yy_leftButtonAndImageWithSpacing:(CGFloat)spacing {
    CGFloat insetAmount = spacing / 2.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
}

- (void)yy_rightButtonAndImageWithSpcing:(CGFloat)spacing {
    CGFloat insetAmount = spacing / 2.0;
    CGSize titleSize = [self.titleLabel.text yy_sizeForFont:self.titleLabel.font];
    CGSize imageSize = self.imageView.bounds.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + insetAmount, 0, - (titleSize.width+ insetAmount));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + insetAmount), 0, imageSize.width + insetAmount);
}

- (void)yy_bottomTitleAndImageWithSpacing:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = [self.titleLabel.text yy_sizeForFont:self.titleLabel.font];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height-titleSize.height - spacing, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -titleSize.width);
}

- (void)yy_bottomButtonAndImageWithSpacing:(CGFloat)spacing {
    BOOL spacingIfNeed = NO;
    [[self bk_associatedValueForKey:kBottomButtonAndImageWithSpacing] getValue:&spacingIfNeed];
    if (!spacingIfNeed) {
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = [self.titleLabel.text yy_sizeForFont:self.titleLabel.font];
        
        CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
        
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height),
                                                0.0f,
                                                0.0f,
                                                - titleSize.width);
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                                -imageSize.width,
                                                -(totalHeight - titleSize.height),
                                                0.0f);
        [self bk_associateValue:@(YES) withKey:kBottomButtonAndImageWithSpacing];
    }
}

- (void)yy_bottomButtonAndImageSpacingIfNeed {
    [self bk_associateValue:@(NO) withKey:kBottomButtonAndImageWithSpacing];
}

- (void)yy_setNormalImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)yy_setHighlightedImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)yy_setSelectedNormalImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

- (void)yy_setSelectedHighlightedImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected | UIControlStateHighlighted];
}

@end
