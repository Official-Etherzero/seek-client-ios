#import <UIKit/UIKit.h>

@class UIFont;

@interface NSString (Ext)


- (CGSize)yy_sizeForFont:(UIFont *)font;

- (NSMutableAttributedString *)yy_attributeRangeStringWithRangeString:(NSString *)rangeString rangeStringFont:(UIFont *)rangeStringFont;

- (NSMutableAttributedString *)yy_attributeRangeStringWithRangeString:(NSString *)rangeString rangeStringColor:(UIColor *)rangeStringColor rangeStringFont:(UIFont *)rangeStringFont;

+ (BOOL)yy_isNilRoEmpty:(NSString *)str;

- (BOOL)yy_isNilRoEmpty;

- (NSString *)yy_trim;

- (BOOL)yy_isEmail;

- (NSInteger)yy_toCharacter;

+ (NSString *)subStringWith:(NSString *)string ToIndex:(NSInteger)index;

+ (BOOL)yy_isHaveLetters:(NSString *)str;

+ (BOOL)yy_isSmaeDay;

+ (NSString *)yy_currentDay;

- (NSString *)yy_holdDecimalPlaceToIndex:(NSInteger)index;

+ (NSString *)yy_dictionaryToJson:(NSDictionary *)dic;

- (BOOL)yy_isValidUrl;

@end
