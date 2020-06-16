#import <UIKit/UIKit.h>

@interface UILabel (Ext)

+ (instancetype)yy_shadowText;

- (void)yy_timeDuration:(NSTimeInterval)duration;

/**
 设置富文本
 设置完成后重新计算高度
 @param targetString 转变的目标字符串
 @param font 转变字体
 @param color 转变颜色
 */
- (void) yy_attributedString:(NSString *)targetString font:(UIFont *)font color:(UIColor *)color;


- (void)yy_setLineSpace:(float)space;

- (void)yy_setWordSpace:(float)space;

/** 字边距和行边距
 @param lineSpace 行边距
 @param wordSpace 字边距
 */
- (void)yy_setSpacewithLineSpace:(float)lineSpace
                       wordSpace:(float)wordSpace;

/** 根据字体和文本获取 label 的宽度和高度
 @param title label 文本
 @param width label 的宽度
 @param font  label 的文本字体
 */

- (CGFloat)getHeightByWidth:(CGFloat)width
                      title:(NSString *)title
                       font:(UIFont *)font;

- (CGFloat)getWidthWithTitle:(NSString *)title
                        font:(UIFont *)font;

/** 获取当前文本需要的行数*/
- (NSInteger)yy_needLinesByWidth:(CGFloat)width;

/** 高度自适应 && 宽度自适应*/
-(void)yy_adaptContentFitHeight;

-(void)yy_adaptContentFitWidth;

@end
