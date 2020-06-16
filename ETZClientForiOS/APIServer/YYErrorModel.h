//
//  YYErrorModel.h
//  XXClientForiOS
//
//  Created by yang on 2018/10/26.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYErrorModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic,   copy) NSString  *msg;
@property (nonatomic, strong) NSError   *error;

- (id)initWithJsonObject:(NSDictionary *)jsonItem;

@end

NS_ASSUME_NONNULL_END
