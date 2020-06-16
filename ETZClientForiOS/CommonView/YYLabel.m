//
//  YYLabel.m
//  Video_edit
//
//  Created by yang on 2018/9/27.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYLabel.h"

@implementation YYLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    _textInsets = textInsets;
}

// 这里单独设置内边距为 3 个像素
- (void)updateLabelTextFrame:(CGFloat)textFontSize point:(CGPoint)point {
    CGSize size = [self textLabelSize:textFontSize];
    // height
    CGFloat height = size.height + 3;
    // width
    CGFloat width = size.width + 3;
    if (width < height) {
        width = height;
    }
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = height /2.0;
    self.frame = CGRectMake(point.x,
                            point.y, width,height);
}

- (void)setDefaultTextFrame:(CGFloat)textFontSize point:(CGPoint)point {
    
    CGSize size = [self textLabelSize:textFontSize];
    CGFloat height = size.height;
    CGFloat width = size.width;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = height /2.0;
    self.frame = CGRectMake(point.x,
                            point.y, width,height);
}

- (void)setTextInsetsZero:(CGFloat)textFontSize point:(CGPoint)point {
    
    CGSize size = [self textLabelSize:textFontSize];
    CGFloat height = size.height;
    CGFloat width = size.width;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = height /2.0;
    self.frame = CGRectMake(point.x,
                            point.y, width,height);
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
    if (self.borderColor) {
        CGSize shadowOffset = self.shadowOffset;
        UIColor *textColor = self.textColor;
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.borderWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.borderColor;
        [super drawTextInRect:rect];
        
        CGContextSetTextDrawingMode(c, kCGTextFill);
        self.textColor = textColor;
        self.shadowOffset = CGSizeMake(0, 0);
        [super drawTextInRect:rect];
        self.shadowOffset = shadowOffset;
    }
}

#pragma mark - private

- (CGSize)textLabelSize:(CGFloat)textFontSize {
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:textFontSize];
    self.font = fnt;
    // 根据字体得到 NSString 的尺寸
    CGSize size = [self.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    return size;
}
@end
