//
//  YYProgressLayer.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/15.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYProgressLayer : CAShapeLayer

+ (instancetype)layerWithFrame:(CGRect)frame;
- (void)finishedLoad;
- (void)startLoad;
- (void)closeTimer;

@end

NS_ASSUME_NONNULL_END
