//
//  NSTimer+Ext.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/15.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Ext)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

+ (NSTimer *)yy_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                       repeats:(BOOL)isRepeat
                                         block:(void(^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
