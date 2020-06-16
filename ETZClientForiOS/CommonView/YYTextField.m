//
//  YYTextField.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYTextField.h"

@implementation YYTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        if (_disableCopy) {
            return NO;
        }
    }
    if (action == @selector(paste:)) {
        if (_disablePaste) {
            return NO;
        }
    }
    return [super canPerformAction:action withSender:sender];
}

@end
