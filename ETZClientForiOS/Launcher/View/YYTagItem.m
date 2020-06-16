//
//  YYTagItem.m
//  TAGViewDemo
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYTagItem.h"

@implementation YYTagItem

- (instancetype)init {
    if (self = [super init]) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        self.delegate = self;
        self.tintColor = [UIColor clearColor];
    }
    return self;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    [textField resignFirstResponder];
    if ([self.tagDelegate respondsToSelector:@selector(yy_tagItem:)]) {
        [self.tagDelegate yy_tagItem:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)setEditShowColor:(UIColor *)EditShowColor {
    self.backgroundColor = EditShowColor;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.padding.left,
                      bounds.origin.y + self.padding.top,
                      bounds.size.width - self.padding.right - self.padding.left,
                      bounds.size.height - self.padding.bottom - self.padding.bottom);
}

- (void)setPadding:(UIEdgeInsets)padding {
    _padding = padding;
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
