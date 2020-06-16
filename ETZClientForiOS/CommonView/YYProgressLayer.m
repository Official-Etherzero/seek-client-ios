//
//  YYProgressLayer.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/15.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYProgressLayer.h"
#import "NSTimer+Ext.h"
#import "YYViewHeader.h"

static NSTimeInterval const kFastTimeInterval = 0.03;

@interface YYProgressLayer ()

@property (nonatomic, strong) CAShapeLayer  *layer;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, assign) CGFloat       plusWidth;

@end

@implementation YYProgressLayer

+ (instancetype)layerWithFrame:(CGRect)frame {
    YYProgressLayer *layer = [self new];
    layer.frame = frame;
    return layer;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.anchorPoint = CGPointMake(0, 0.5);
    self.lineWidth = 2;
    self.strokeColor = COLOR_30D1A1.CGColor;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer yy_scheduledTimerWithTimeInterval:kFastTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf pathChanged:timer];
    }];
    [self.timer pause];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(YYSCREEN_WIDTH, 2)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    self.plusWidth = 0.01;
}

- (void)pathChanged:(NSTimer *)timer {
    if (self.strokeEnd >= 0.97) {
        [self.timer pause];
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd += self.plusWidth;
    
    if (self.strokeEnd > 0.8) {
        self.plusWidth = 0.001;
    }
    [CATransaction commit];
}

- (void)startLoad {
    [self.timer resumeWithTimeInterval:kFastTimeInterval];
}

- (void)finishedLoad {
    [self closeTimer];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd = 1.0;
    [CATransaction commit];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
}

- (void)dealloc {
    [self closeTimer];
}

#pragma mark - private
- (void)closeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
