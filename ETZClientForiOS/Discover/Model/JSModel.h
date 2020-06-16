//
//  JSModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/8.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSModel : NSObject

@property (nonatomic,   copy) NSString *contractAddress;
@property (nonatomic,   copy) NSString *etzValue;
@property (nonatomic,   copy) NSString *datas;
@property (nonatomic,   copy) NSString *keyTime;
@property (nonatomic,   copy) NSString *gasLimit;
@property (nonatomic,   copy) NSString *gasPrice;

- (instancetype)initWithJsonModel:(NSString *)jsons;

@end

NS_ASSUME_NONNULL_END
