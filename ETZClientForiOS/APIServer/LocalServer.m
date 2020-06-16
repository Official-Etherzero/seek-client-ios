//
//  LocalServer.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "LocalServer.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import "YYInterfaceMacro.h"

@implementation LocalServer

+ (void)syncPhotoAlbumForAuthorizationCompleteHandler:(void (^)(NSError *error))completeHandler; {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            if (completeHandler) {
                dispatch_async_main_safe(^{
                    completeHandler([NSError errorWithDomain:@"用户拒绝" code:PHAuthorizationStatusDenied userInfo:nil]);
                });
                return;
            }
        } else {
            dispatch_async_main_safe(^{
                if (completeHandler) {
                    completeHandler(nil);
                }
            });
        }
    }];
}


+ (void)syncAVCaptureDeviceForAuthorizationCompleteHandler:(void (^)(NSError *error))completeHandler {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied) {
            dispatch_async_main_safe(^{
                completeHandler([NSError errorWithDomain:@"用户拒绝" code:PHAuthorizationStatusDenied userInfo:nil]);
            });
        } else {
            dispatch_async_main_safe(^{
                if (completeHandler) {
                    completeHandler(nil);
                }
            });
        }
       
    }
}


@end
