//
//  YYSettingLanguage.m
//  Video_edit
//
//  Created by yang on 2018/9/11.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYSettingLanguage.h"
#import "YYLanguageTool.h"
    
@implementation YYSettingLanguage
    
+ (YYSettingLanguageType)currentLanguageType {
    YYSettingLanguageType type;
    [[[NSUserDefaults standardUserDefaults] valueForKey:kYYSettingLanguageType] getValue:&type];
    if (!type) {
        NSString *pfLanguageCode = [NSLocale preferredLanguages][0];
        NSLog(@"pfLanguageCode %@", pfLanguageCode);
    }
    return type;
}
    
@end

NSString *YYSettingLanguageTypeDesc(YYSettingLanguageType type) {
    switch (type) {
        case YYSettingLanguageTypeUndefined:
            return YYStringWithKey(@"English");
        case YYSettingLanguageTypeChineseSimple:
            return YYStringWithKey(@"简体中文");
        case YYSettingLanguageTypeEnglish:
            return YYStringWithKey(@"English");
        case YYSettingLanguageTypeKorea:
            return YYStringWithKey(@"한글");
    }
    return @"";
}


