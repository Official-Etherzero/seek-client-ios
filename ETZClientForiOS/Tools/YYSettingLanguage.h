//
//  YYSettingLanguage.h
//  Video_edit
//
//  Created by yang on 2018/9/11.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YYSettingLanguageType) {
    YYSettingLanguageTypeUndefined = 0,
    YYSettingLanguageTypeChineseSimple = 1,
    YYSettingLanguageTypeEnglish,
    YYSettingLanguageTypeKorea,
};
    
@interface YYSettingLanguage : NSObject
    
+ (YYSettingLanguageType)currentLanguageType;
   
@end

NSString *YYSettingLanguageTypeDesc(YYSettingLanguageType type);


static NSString *kYYSettingLanguageType = @"kYYSettingLanguageType";



