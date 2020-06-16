//
//  YYLanguageTool.h
//  Video_edit
//
//  Created by yang on 2018/9/11.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYSettingLanguage.h"

#define YYStringWithKey(key) \
[[YYLanguageTool shareInstance] stringWithKey:key table:@"Localizable"]

@interface YYLanguageTool : NSObject
    
+ (instancetype)shareInstance;
    
- (NSString *)stringWithKey:(NSString *)key table:(NSString *)table;
    
- (void)setLanguage:(YYSettingLanguageType)languageType;
    
- (YYSettingLanguageType)currentType;

@end
