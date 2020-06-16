//
//  HttpModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/11/28.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray  *result;

@end

NS_ASSUME_NONNULL_END
