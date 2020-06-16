//
//  RateModel.h
//  ETZClientForiOS
//
//  Created by etz on 2019/11/14.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RateModel : NSObject

@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *code;
@property (nonatomic, assign) float    rate;
@property (nonatomic, assign) float    price;

@end

NS_ASSUME_NONNULL_END
