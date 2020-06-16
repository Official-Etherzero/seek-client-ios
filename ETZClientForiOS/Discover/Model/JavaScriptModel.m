//
//  JavaScriptModel.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/8.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "JavaScriptModel.h"
#import "WalletDataManager.h"
#import "YYLanguageTool.h"


@implementation JavaScriptModel

- (void)etzTransaction:(NSString *)jsons {
    if (self.sendTranscation) {
        self.sendTranscation(jsons);
    }
}

- (NSString *)getAddress {
    NSLog(@"调用了获取地址的方法");
    return [WalletDataManager accountModel].address;
}

- (void)landscapeAndHideTitle {
    if (self.landscapeBlock) {
        self.landscapeBlock();
    }
}

- (void)backToPortrait {
    if (self.portraitBlock) {
        self.portraitBlock();
    }
}

- (NSString *_Nonnull)getMinerInfo {
    return self.minerInfo;
}

- (NSString *)getCurrentLanguage {
    NSLog(@"调用了获取语言的方法");
    YYSettingLanguageType type = [[YYLanguageTool shareInstance] currentType];
    switch (type) {
        case YYSettingLanguageTypeChineseSimple:
            return @"CNS";
        case YYSettingLanguageTypeEnglish:
            return @"EN";
        case YYSettingLanguageTypeKorea:
            return @"KO";
        default:
            return @"EN";
    }
    return @"EN";
}

- (void)setMinerInfo:(id)minerInfo {
    _minerInfo = minerInfo;
}

@end
