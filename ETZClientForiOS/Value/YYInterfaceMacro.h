//
//  YYInterfaceMacro.h
//  Video_edit
//
//  Created by yang on 2018/9/18.
//  Copyright © 2018年 m-h. All rights reserved.
//

#ifndef YYInterfaceMacro_h
#define YYInterfaceMacro_h

#define EXPORT_ABLUMN @"ETZClientForiOS"

#define WDWeakify(o)        __weak   typeof(self) mmwo = o;
#define WDStrongify(o)      __strong typeof(self) o = mmwo;

#define NSIndexPathEqual(a,b) (a.row == b.row && a.section == b.section)

#define dispatch_async_main_safe(block) \
if ([NSThread isMainThread]) { \
block(); \
}else { \
dispatch_async(dispatch_get_main_queue(), block); \
}

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define ISETHADDRESS(str)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^0[xX][0-9a-fA-F]{40}$"] evaluateWithObject:str]

/** app 前后台切换*/
static NSString *kEnterBackground = @"kEnterBackground";
static NSString *kBecomeActive = @"kBecomeActive";
static NSString *kWillTerminate = @"kWillTerminate";

// 是不是首次启动 App
static NSString *const kIsFirstLauchApp = @"kIsFirstLauchApp";

// 最后一次设置的语言
static NSString *const kLastLanguage = @"kLastLanguage";

// 钱包
// 当前选择钱包地址
static NSString *kAPIAccountModel = @"kAPIAccountModel";
static NSString *kAPIAccountModelInfo = @"kkAPIAccountModelInfo";

// 所有钱包地址
static NSString *kAPIWalletList = @"kAPIWalletList";
static NSString *kAPIWalletListInfo = @"kAPIWalletListInfo";

// 汇率
static NSString *kExchageRate = @"kExchageRate";
static NSString *kExchageRateInfo = @"kExchageRateInfo";

// 代币
static NSString *kTokenList = @"kTokenList";
//static NSString *kAPITokenListInfo = @"kAPITokenListInfo";

// 关闭广告栏时间
static NSString *kMarkCurrentTime = @"nextShowTime";

// hash 值
static NSString *kTransferHash = @"kTransferHash";
static NSString *kTransferHashInfo = @"kTransferHashInfo";


/** language*/
#define CNS @"zh-Hans"
#define CNT @"zh-Hant"
#define EN @"en"
#define JA @"ja"
#define KO @"ko"

/**account */
#define BuglyID @"a6012f010f"

#endif /* YYInterfaceMacro_h */
