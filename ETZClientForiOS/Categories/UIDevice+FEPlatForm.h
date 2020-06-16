//
//  UIDevice+FEPlatForm.h
//  FEDevice
//
//  Created by keso on 16/1/4.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIDevice4,
    UIDevice4S,
    UIDevice5,
    UIDevice5C,
    UIDevice5S,
    UIDevice6,
    UIDevice6P,
    UIDevice6S,
    UIDevice6SE,
    UIDevice6SP,
    UIDevice7,
    UIDevice7P,
    UIDeviceUnknow
} UIDeviceType;

@interface UIDevice (FEPlatForm)

+ (UIDeviceType)devicePlatForm;
+ (NSString *)getDeviceName;

@end
