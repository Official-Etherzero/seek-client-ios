#import <UIKit/UIKit.h>

@interface UIButton (Ext)

- (void)yy_centerButtonAndImageWithSpacing:(CGFloat)spacing;

- (void)yy_bottomButtonAndImageWithSpacing:(CGFloat)spacing;

- (void)yy_topButtonAndImageWithSpacing:(CGFloat)spacing;

- (void)yy_leftButtonAndImageWithSpacing:(CGFloat)spacing;

- (void)yy_rightButtonAndImageWithSpcing:(CGFloat)spacing;

- (void)yy_bottomTitleAndImageWithSpacing:(CGFloat)spacing;

- (void)yy_bottomButtonAndImageSpacingIfNeed;

- (void)yy_setNormalImage:(NSString *)imageName;

- (void)yy_setHighlightedImage:(NSString *)imageName;

- (void)yy_setSelectedNormalImage:(NSString *)imageName;

- (void)yy_setSelectedHighlightedImage:(NSString *)imageName;

@end
