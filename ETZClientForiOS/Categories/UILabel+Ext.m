#import "UILabel+Ext.h"
#import "YYColor.h"

@implementation UILabel (Ext)

+ (instancetype)yy_shadowText {
    UILabel *lbl = ({
        UILabel *v = [[UILabel alloc] initWithFrame:CGRectZero];
        v.textColor = COLOR_ffffff;
        v.textAlignment = NSTextAlignmentCenter;
        v.layer.shadowColor = COLOR_909090.CGColor;
        v.layer.shadowRadius = 0.5;
        v.layer.shadowOpacity = 1.0;
        v.layer.shadowOffset = CGSizeMake(1, 1);
        [v sizeToFit];
        v;
    });
    return lbl;
}

- (void)yy_timeDuration:(NSTimeInterval)duration {
    if (duration <= 0) {
        self.text = @"00:00";
    } else {
        NSInteger intDuration = ceil(duration);
        self.text = [NSString stringWithFormat:@"%02d:%02d",(int) (intDuration / 60),(int)(intDuration % 60)];
    }
    
}

- (void)yy_attributedString:(NSString *)targetString font:(UIFont *)font color:(UIColor *)color {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UIFont *selfFont = self.font;
    NSString *selfText = self.text == nil? targetString : self.text;
    
    NSDictionary *attributedStringDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,color,NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc] initWithString:selfText];
    NSRange range = [[titleAttributedString string] rangeOfString:targetString options:NSBackwardsSearch];
    [titleAttributedString addAttributes:attributedStringDic range:range];
    self.attributedText = titleAttributedString;
    
    UIFont *targetFont = selfFont;
    if (selfFont.lineHeight < font.lineHeight) {
        targetFont = font;
    }
    NSDictionary *sizeDic = [NSDictionary dictionaryWithObjectsAndKeys:targetFont, NSFontAttributeName,nil];
    CGSize actualSize = [selfText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:sizeDic context:nil].size;
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y ,actualSize.width, actualSize.height);
}

- (void)yy_setLineSpace:(float)space {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)yy_setWordSpace:(float)space {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)yy_setSpacewithLineSpace:(float)lineSpace
                       wordSpace:(float)wordSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (CGFloat)getHeightByWidth:(CGFloat)width
                      title:(NSString *)title
                       font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return ceil(height);
}

- (CGFloat)getWidthWithTitle:(NSString *)title
                        font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    return ceil(width);
}

- (NSInteger)yy_needLinesByWidth:(CGFloat)width {
    UILabel *v = [UILabel new];
    v.font = self.font;
    NSString *text = self.text;
    NSInteger sum = 0;
    // 换行符号
    NSArray *rowType = [text componentsSeparatedByString:@"\n"];
    for (NSString *c in rowType) {
        v.text = c;
        CGSize textSize = [v systemLayoutSizeFittingSize:CGSizeZero];
        NSInteger lines = ceilf(textSize.width / width);
        lines = lines == 0 ? 1 : lines;
        sum += lines;
    }
    return sum;
}

-(void)yy_adaptContentFitHeight {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    label.text = self.text;
    label.font = self.font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    self.numberOfLines = 0;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,  self.frame.size.width, height);
}

-(void)yy_adaptContentFitWidth {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, 0)];
    label.text = self.text;
    label.font = self.font;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}



@end
