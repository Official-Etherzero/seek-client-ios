//
//  YYImportInfo.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/21.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,YYImportStyle){
    YYImportMnemonic   = 0,
    YYImportPrivateKey = 1,
    YYImportKeystore   = 2,
};

@interface YYImportInfo : NSObject

@property (nonatomic, assign) YYImportStyle  style;     // 导入的类型
@property (nonatomic,   copy) NSString       *name;     // 备注名
@property (nonatomic,   copy) NSString       *content;  // 导入内容
@property (nonatomic,   copy) NSString       *psw;      // 密码

@end

NS_ASSUME_NONNULL_END
