//
//  YYErrorModel.m
//  XXClientForiOS
//
//  Created by yang on 2018/10/26.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "YYErrorModel.h"

@implementation YYErrorModel

- (id)initWithJsonObject:(NSDictionary *)jsonItem {
    
    if (jsonItem && jsonItem != (id)[NSNull null]) {
        [self setValuesForKeysWithDictionary:jsonItem];
    }
    
    return self;
}

@end
