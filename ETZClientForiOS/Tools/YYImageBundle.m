//
//  YYImageBundle.m
//  Video_edit
//
//  Created by yang on 2018/10/16.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYImageBundle.h"

@implementation YYImageBundle

+ (NSArray *)loadingAnimation {
    NSMutableArray *imagePaths = @[].mutableCopy;
    for (int i = 1; i <= 5; ++i) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"loading0%@.png", @(i)] ofType:nil];
        [imagePaths addObject:path];
    }
    return imagePaths.copy;
}

@end
