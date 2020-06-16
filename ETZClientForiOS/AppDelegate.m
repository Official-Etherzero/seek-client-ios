//
//  AppDelegate.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "AppDelegate.h"
#import "YYLanguageTool.h"
#import "YYInterfaceMacro.h"
#import "BaiduMobStat.h"
#import "WDLauncherViewController.h"
#import "WDDataBaseManager.h"

@interface AppDelegate ()

/**
 @Parm 矿工
 @parm 百度统计与埋点
 @parm 添加代币
 */

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.supportRotation = UIInterfaceOrientationMaskPortrait;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[WDLauncherViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    // App 语言设置
    [self setAppLanguage];
    
    // Bugly
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self setBugly];
    });
    
    // 防止两个按钮同时点击
    [[UIButton appearance] setExclusiveTouch:YES];
    
    if (@available(iOS 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    // 启动百度统计
    [self startBaiduMobileStat];
    [WDDataBaseManager setDefaultDatabase];
    
    return YES;
}

- (void)startBaiduMobileStat {
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:@"eaea88a644"];
}

- (void)setAppLanguage {
    // handle device language
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    // handle local cache language
    NSString *localCachelg = [[NSUserDefaults standardUserDefaults] valueForKey:kLastLanguage];
    if (![currentLanguage isEqualToString:localCachelg]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentLanguage forKey:kLastLanguage];
        if ([currentLanguage containsString:CNS]) {
            [[YYLanguageTool shareInstance] setLanguage:YYSettingLanguageTypeChineseSimple];
        } else if ([currentLanguage containsString:KO]) {
            [[YYLanguageTool shareInstance] setLanguage:YYSettingLanguageTypeKorea];
        } else {
            [[YYLanguageTool shareInstance] setLanguage:YYSettingLanguageTypeEnglish];
        }
    }
}

- (void)setBugly {
    
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return self.supportRotation;
}

- (void)applicationWillResignActive:(UIApplication *)application {}


- (void)applicationDidEnterBackground:(UIApplication *)application {}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:kEnterBackground object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:kBecomeActive object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:kWillTerminate object:nil];
}


@end
