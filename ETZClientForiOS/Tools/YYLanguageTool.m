//
//  YYLanguageTool.m
//  Video_edit
//
//  Created by yang on 2018/9/11.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYLanguageTool.h"
#import "YYInterfaceMacro.h"

NSString *kLANGUAGE = @"kLANGUAGE";

@implementation YYLanguageTool {
    NSBundle *_bundle;
    NSString *_language;
}
    
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static YYLanguageTool *tool;
    dispatch_once(&onceToken, ^{
        tool = [YYLanguageTool new];
    });
    return tool;
}
    
- (instancetype)init {
    self = [super init];
    if (self) {
        YYSettingLanguageType user = [self userLanguageType];
        if (user != YYSettingLanguageTypeUndefined) {
            [self setLanguage:user];
        } else {
            NSString *system = [self systemLanguageType];
            _language = system;
            _bundle = [self getLanguageBundleByType:system];
        }
    }
    return self;
}
    
- (YYSettingLanguageType)currentType {
    return [self toType:_language];
}
    
- (NSString *)stringWithKey:(NSString *)key table:(NSString *)table {
    NSString *value = @"";
    if (_bundle) {
        value = NSLocalizedStringFromTableInBundle(key, table, _bundle, @"");
    } else {
        value = NSLocalizedStringFromTable(key, table, @"");
    }
    /*
    // app名称
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if ([value rangeOfString:REAL_APP_NAME].location != NSNotFound) {
        value = [value stringByReplacingOccurrencesOfString:REAL_APP_NAME withString:app_Name];
    }
     */
    return value;
}
    
- (void)setLanguage:(YYSettingLanguageType)languageType {
    switch (languageType) {
        case YYSettingLanguageTypeChineseSimple:
            [[NSUserDefaults standardUserDefaults] setObject:CNS forKey:kLANGUAGE];
            break;
//        case YYSettingLanguageTypeChineseTraditional:
//            [[NSUserDefaults standardUserDefaults] setObject:CNT forKey:kLANGUAGE];
//            break;
        case YYSettingLanguageTypeEnglish:
            [[NSUserDefaults standardUserDefaults] setObject:EN forKey:kLANGUAGE];
            break;
//        case YYSettingLanguageTypeJapanese:
//            [[NSUserDefaults standardUserDefaults] setObject:JA forKey:kLANGUAGE];
//            break;
        case YYSettingLanguageTypeKorea:
            [[NSUserDefaults standardUserDefaults] setObject:KO forKey:kLANGUAGE];
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kLANGUAGE];
    _language = currentLanguage ?: CNS;
    NSString *path = [[NSBundle mainBundle] pathForResource:_language ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
}
    
- (NSBundle *)getLanguageBundleByType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:type ofType:@"lproj"];
    return [NSBundle bundleWithPath:path];
}
    
- (YYSettingLanguageType)userLanguageType {
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kLANGUAGE];
    if (currentLanguage) {
        return [self toType:currentLanguage];
    }
    return YYSettingLanguageTypeUndefined;
}
    
- (NSString *)systemLanguageType {
    NSString *systemLanguage  = [[NSBundle mainBundle] preferredLocalizations].firstObject;
    return systemLanguage;
}
    
- (YYSettingLanguageType)toType:(NSString *)str {
    if ([str isEqualToString:CNS]) {
        return YYSettingLanguageTypeChineseSimple;
    }
//    if ([str isEqualToString:CNT]) {
//        return YYSettingLanguageTypeChineseTraditional;
//    }
    if ([str isEqualToString:EN]) {
        return YYSettingLanguageTypeEnglish;
    }
//    if ([str isEqualToString:JA]) {
//        return YYSettingLanguageTypeJapanese;
//    }
    if ([str isEqualToString:KO]) {
        return YYSettingLanguageTypeKorea;
    }
    return YYSettingLanguageTypeEnglish;
}

@end
