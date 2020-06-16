//
//  UIDevice+FEPlatForm.m
//  FEDevice
//
//  Created by keso on 16/1/4.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "UIDevice+FEPlatForm.h"
#import <sys/utsname.h>

@implementation UIDevice (FEPlatForm)

+ (UIDeviceType)devicePlatForm{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"]) return UIDevice4;
    if ([platform isEqualToString:@"iPhone3,2"]) return UIDevice4;
    if ([platform isEqualToString:@"iPhone3,3"]) return UIDevice4;
    if ([platform isEqualToString:@"iPhone4,1"]) return UIDevice4S;
    if ([platform isEqualToString:@"iPhone5,1"]) return UIDevice5;
    if ([platform isEqualToString:@"iPhone5,2"]) return UIDevice5;
    if ([platform isEqualToString:@"iPhone5,3"]) return UIDevice5C;
    if ([platform isEqualToString:@"iPhone5,4"]) return UIDevice5C;
    if ([platform isEqualToString:@"iPhone6,1"]) return UIDevice5S;
    if ([platform isEqualToString:@"iPhone6,2"]) return UIDevice5S;
    if ([platform isEqualToString:@"iPhone7,1"]) return UIDevice6;
    if ([platform isEqualToString:@"iPhone7,2"]) return UIDevice6P;
    if ([platform isEqualToString:@"iPhone8,1"])    return UIDevice6S;
    if ([platform isEqualToString:@"iPhone8,2"])    return UIDevice6SP;
    if ([platform isEqualToString:@"iPhone8,4"])    return UIDevice6SE;
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([platform isEqualToString:@"iPhone9,1"])    return UIDevice7;
    if ([platform isEqualToString:@"iPhone9,2"])    return UIDevice7P;
    if ([platform isEqualToString:@"iPhone9,3"])    return UIDevice7;
    if ([platform isEqualToString:@"iPhone9,4"])    return UIDevice7P;
    //http://www.cnblogs.com/xiaofeixiang/
//    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
//    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
//    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
//    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
//    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
//    
//    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
//    
//    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
//    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
//    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
//    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
//    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
//    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
//    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
//    
//    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
//    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
//    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
//    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
//    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
//    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
//    
//    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
//    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
//    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
//    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
//    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
//    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
//    
//    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
//    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return UIDeviceUnknow;
}

// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone7Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPadMini";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPadMini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPadMini";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad4";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPadMini2";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPadMini2";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPadMini2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPadMini3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPadMini3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPadMini3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPadMini4";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPadMini4";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPadPro9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPadPro9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPadPro12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPadPro12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

@end
