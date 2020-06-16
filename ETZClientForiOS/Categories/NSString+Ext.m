#import <UIKit/UIKit.h>
#import "NSString+Ext.h"
#import "RegExCategories.h"

@implementation NSString (Ext)

- (CGSize)yy_sizeForFont:(UIFont *)font {
    CGSize size = CGSizeMake(HUGE, HUGE);
    NSLineBreakMode lineBreakMode = NSLineBreakByWordWrapping;
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (NSMutableAttributedString *)yy_attributeRangeStringWithRangeString:(NSString *)rangeString rangeStringFont:(UIFont *)rangeStringFont {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:rangeString];
    [attributeString addAttribute:NSFontAttributeName value:rangeStringFont range:range];

    return [attributeString copy];
}

- (NSMutableAttributedString *)yy_attributeRangeStringWithRangeString:(NSString *)rangeString
                                                      rangeStringColor:(UIColor *)rangeStringColor
                                                       rangeStringFont:(UIFont *)rangeStringFont {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:rangeString];

    [attributeString addAttribute:NSForegroundColorAttributeName value:rangeStringColor range:range];
    [attributeString addAttribute:NSFontAttributeName value:rangeStringFont range:range];

    return [attributeString copy];
}

+ (BOOL)yy_isNilRoEmpty:(NSString *)str {
    if (!str) {
        return YES;
    }
    return [str isEqualToString:@""];
}

- (BOOL)yy_isNilRoEmpty {
    if (!self) {
        return YES;
    }
    return [self isEqualToString:@""];
}

- (BOOL)yy_isEmail {
    return ![self yy_isNilRoEmpty]
     &&[self isMatch:RX(@"^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$")];
}

- (NSString *)yy_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSInteger)yy_toCharacter {
    NSInteger code = 0;
    for (int i = 0; i < self.length; i++) {
        code += [self characterAtIndex:i];
    }
    return code;
}

+ (NSString *)subStringWith:(NSString *)string ToIndex:(NSInteger)index {
    NSString *result = string;
    if (result.length > index) {
        NSRange rangeIndex = [result rangeOfComposedCharacterSequenceAtIndex:index];
        result = [result substringToIndex:(rangeIndex.location)];
    }
    
    return result;
}

+ (BOOL)yy_isHaveLetters:(NSString *)str {
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    if (tLetterMatchCount > 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)yy_currentDay {
    // 只记录东八区 年月日
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+ (BOOL)yy_isSmaeDay {
    /*
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:finder_lastTime] isEqualToString:[self yy_currentDay]]) {
        return YES;
    }
     */
    return NO;
}

- (NSString *)yy_holdDecimalPlaceToIndex:(NSInteger)index {
    if (!self) {
        return @"0";
    }
    NSArray *arr = [self componentsSeparatedByString:@"."];
    if (arr.count == 1) {
        return arr.firstObject;
    }
    NSString *firstStr = [arr objectAtIndex:0];
    NSString *secondStr = [arr objectAtIndex:1];
    if (secondStr.length > index) {
        secondStr = [secondStr substringWithRange:NSMakeRange(0, index)];
    }
    return [NSString stringWithFormat:@"%@.%@",firstStr,secondStr];
}


+ (NSString *)yy_dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (BOOL)yy_isValidUrl {
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
     

@end
