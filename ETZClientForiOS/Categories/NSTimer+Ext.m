//
//  NSTimer+Ext.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/15.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "NSTimer+Ext.h"

@implementation NSTimer (Ext)

- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

+ (NSTimer *)yy_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                       repeats:(BOOL)isRepeat
                                         block:(void(^)(NSTimer *timer))block {
    
    return [self scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeFired:) userInfo:block repeats:isRepeat];
}

+ (void)timeFired:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
