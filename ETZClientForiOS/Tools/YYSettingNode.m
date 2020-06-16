//
//  YYSettingNode.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/10.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYSettingNode.h"
#import "YYLanguageTool.h"

@implementation YYSettingNode

+ (void)yy_setNodeType:(YYSettingNodeType)type {
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kYYSettingNodeType];
}

+ (YYSettingNodeType)currentNodeType {
    NSInteger type = [[NSUserDefaults standardUserDefaults] integerForKey:kYYSettingNodeType];
    return type == 0 ? YYSettingNodeTypeSingapore : type;
}

+ (NSString *)currentNodeIp {
    YYSettingNodeType type = [self currentNodeType];
    switch (type) {
        case YYSettingNodeTypeUndefined: {
            return @"http://13.251.6.203:8545";
        }
        case YYSettingNodeTyoeGuangzhou:{
            return @"http://182.61.139.140:8545";
        }
//        case YYSettingNodeTypeChinese:{
//            // 这个是新加坡的
//            return @"http://13.250.204.142:8545";
//        }
        case YYSettingNodeTypeAmerican: {
            return @"http://104.236.240.227:8545";
        }
        case YYSettingNodeTypeKorea: {
            // 这个目前也是新加坡的
            return @"http://13.251.6.203:8545";
        }
//        case YYSettingNodeTypeHongKong: {
//            return @"http://182.61.110.193:8545";
//        }
        case YYSettingNodeTypeSingapore:{
            // http://13.250.204.142:8545 AWS 新加坡
            return @"http://13.251.6.203:8545";
        }
    }
    return @"";
}

NSString *YYSettingNodeTypeDes(YYSettingNodeType type) {
    switch (type) {
        case YYSettingNodeTypeUndefined:
            return @"";
        case YYSettingNodeTyoeGuangzhou:
            return YYStringWithKey(@"广州");
            //        case YYSettingNodeTypeChinese:
            //            return YYStringWithKey(@"中国");
        case YYSettingNodeTypeAmerican:
            return YYStringWithKey(@"美国");
        case YYSettingNodeTypeKorea:
            return YYStringWithKey(@"韩国");
            //        case YYSettingNodeTypeHongKong:
            //            return YYStringWithKey(@"香港");
        case YYSettingNodeTypeSingapore:
            return YYStringWithKey(@"新加坡");
    }
    return @"";
}


@end
