//
//  YYSettingNode.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/10.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YYSettingNodeType) {
    YYSettingNodeTypeUndefined = 0,
//    YYSettingNodeTypeChinese   = 1,
    YYSettingNodeTyoeGuangzhou = 1,
    YYSettingNodeTypeSingapore = 2,
    YYSettingNodeTypeAmerican  = 3,
    YYSettingNodeTypeKorea     = 4,
//    YYSettingNodeTypeHongKong  = 4,
};

NS_ASSUME_NONNULL_BEGIN

static NSString *kYYSettingNodeType = @"kYYSettingNodeType";

@interface YYSettingNode : NSObject

+ (void)yy_setNodeType:(YYSettingNodeType)type;

+ (YYSettingNodeType)currentNodeType;

+ (NSString *)currentNodeIp;

NSString *YYSettingNodeTypeDes(YYSettingNodeType type);




@end

NS_ASSUME_NONNULL_END
