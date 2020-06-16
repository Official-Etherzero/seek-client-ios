//
//  LanguageModel.m
//  ETZClientForiOS
//
//  Created by etz on 2019/11/7.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYLanguageTool.h"


const char *getCurrentLanguage(void) {
    YYSettingLanguageType type = [[YYLanguageTool shareInstance] currentType];
    switch (type) {
        case YYSettingLanguageTypeChineseSimple:
            return [@"CNS" UTF8String];
        case YYSettingLanguageTypeEnglish:
            return [@"EN" UTF8String];
        case YYSettingLanguageTypeKorea:
            return [@"KO" UTF8String];
        default:
            return [@"EN" UTF8String];
    }
    return [@"EN" UTF8String];
}

