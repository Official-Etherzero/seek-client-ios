//
//  YYSecureView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYSecureView.h"
#import "YYViewHeader.h"

@interface YYSecureView ()

@property(nonatomic, strong) NSMutableArray *string;
@property(nonatomic, strong) CALayer        *cursorLayer;

@end

@implementation YYSecureView{
    CGContextRef _ctx;
}
@synthesize secureTextEntry = _secureTextEntry;
@synthesize textColor = _textColor;

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.string = [NSMutableArray array];
        _cursorColor = COLOR_30D1A1;
        self.cursorLayer.backgroundColor = _cursorColor.CGColor;
        [self.layer addSublayer:self.cursorLayer];
        _textFont = [UIFont systemFontOfSize:22];
        _textColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.isSecureTextEntry) {
        // 只有密文才这么输入
        if (_string.count > 0) {
            self.placeHolderLabel.hidden = YES;
        } else {
            self.placeHolderLabel.hidden = NO;
        }
        self.tintColor = [UIColor clearColor];
        CGSize unitSize = CGSizeMake((rect.size.width + _unitSpace) / _inputUnitCount - _unitSpace, rect.size.height);
        
        _ctx = UIGraphicsGetCurrentContext();
        [self _drawText:rect unitSize:unitSize];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (textColor == nil) {
        _textColor = [UIColor blackColor];
    } else {
        _textColor = textColor;
    }
    
    [self setNeedsDisplay];
    [self showOrHideCursorIfNeeded];
}

- (void)insertText:(NSString *)text {
    if (_string.count >= _inputUnitCount) {
        if (_autoResignFirstResponderWhenInputFinished == YES) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self resignFirstResponder];
            }];
        }
        return;
    }
    if ([text isEqualToString:@" "]) {
        return;
    }
    NSRange range;
    for (int i = 0; i < text.length; i += range.length) {
        range = [text rangeOfComposedCharacterSequenceAtIndex:i];
        [_string addObject:[text substringWithRange:range]];
    }
    
    if (_string.count >= _inputUnitCount) {
        [_string removeObjectsInRange:NSMakeRange(_inputUnitCount, _string.count - _inputUnitCount)];
        if (_autoResignFirstResponderWhenInputFinished == YES) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self resignFirstResponder];
            }];
        }
    }
    self.secureContent = [_string componentsJoinedByString:@""];
    [self setNeedsDisplay];
    [self showOrHideCursorIfNeeded];
}

- (void)deleteBackward {
    if ([self hasText] == NO)
        return;
    [_string removeLastObject];
    self.secureContent = [_string componentsJoinedByString:@""];
    [self setNeedsDisplay];
    [self showOrHideCursorIfNeeded];
}

- (void)showOrHideCursorIfNeeded {
    _cursorLayer.hidden = !self.isFirstResponder || _cursorColor == nil || _inputUnitCount == _string.count;
    
    if (_cursorLayer.hidden) return;
    
    CGSize unitSize = CGSizeMake((self.bounds.size.width + _unitSpace) / _inputUnitCount - _unitSpace, self.bounds.size.height);
    
    CGRect unitRect = CGRectMake(_string.count * (unitSize.width + _unitSpace),
                                 0,
                                 unitSize.width,
                                 unitSize.height);
    unitRect = CGRectInset(unitRect,
                           unitRect.size.width / 2 - 1,
                           (unitRect.size.height - _textFont.pointSize) / 2);
    _cursorLayer.frame = unitRect;
}

/**
 绘制文本
 
 当处于密文输入模式时，会用圆圈替代文本。
 
 @param rect 控件绘制的区域
 @param unitSize 单个 input unit 占据的尺寸
 */
- (void)_drawText:(CGRect)rect unitSize:(CGSize)unitSize {
    if ([self hasText] == NO) return;
    
    NSDictionary *attr = @{NSForegroundColorAttributeName: _textColor,
                           NSFontAttributeName: _textFont};
    
    for (int i = 0; i < _string.count; i++) {
        
        CGRect unitRect = CGRectMake(i * (unitSize.width + _unitSpace),
                                     0,
                                     unitSize.width,
                                     unitSize.height);
        
        
        if (_secureTextEntry == NO) {
            NSString *subString = [_string objectAtIndex:i];
            
            CGSize oneTextSize = [subString sizeWithAttributes:attr];
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - oneTextSize.width) / 2,
                                          (unitRect.size.height - oneTextSize.height) / 2);
            [subString drawInRect:drawRect withAttributes:attr];
        } else {
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - _textFont.pointSize / 2) / 2,
                                          (unitRect.size.height - _textFont.pointSize / 2) / 2);
            [_textColor setFill];
            CGContextAddEllipseInRect(_ctx, drawRect);
            CGContextFillPath(_ctx);
        }
    }
}

- (CALayer *)cursorLayer {
    if (!_cursorLayer) {
        _cursorLayer = [CALayer layer];
        _cursorLayer.hidden = YES;
        _cursorLayer.opacity = 1;
        
        CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animate.fromValue = @(0);
        animate.toValue = @(1.5);
        animate.duration = 0.5;
        animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animate.autoreverses = YES;
        animate.removedOnCompletion = NO;
        animate.fillMode = kCAFillModeForwards;
        animate.repeatCount = HUGE_VALF;
        
        [_cursorLayer addAnimation:animate forKey:nil];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self layoutIfNeeded];
            
            _cursorLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / _inputUnitCount / 2, CGRectGetHeight(self.bounds) / 2);
        }];
    }
    
    return _cursorLayer;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    [self setNeedsDisplay];
    [self showOrHideCursorIfNeeded];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    _cursorLayer.backgroundColor = _cursorColor.CGColor;
    [self showOrHideCursorIfNeeded];
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor == nil) {
        _tintColor = [[UIView appearance] tintColor];
    } else {
        _tintColor = tintColor;
    }
    
    [self setNeedsDisplay];
    [self showOrHideCursorIfNeeded];
}

- (BOOL)hasText {
    return _string != nil && _string.count > 0;
}

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    [self showOrHideCursorIfNeeded];
    self.cursorLayer.backgroundColor  = COLOR_30D1A1.CGColor;
    return result;
}

- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    NSLog(@"注册第一响应者");
    self.cursorLayer.backgroundColor = [UIColor clearColor].CGColor;
    return result;
}




@end
