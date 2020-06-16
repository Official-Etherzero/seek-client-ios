//
//  WDSettingLanguageSelectorController.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBaseFunctionController.h"

@protocol WDSettingLanguageSelectorControllerDelegate <NSObject>

- (void)yy_settingLanguageSelectorControllerDidAction;

@end

NS_ASSUME_NONNULL_BEGIN

@interface WDSettingLanguageSelectorController : WDBaseFunctionController

@property (nonatomic,  weak) id<WDSettingLanguageSelectorControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
