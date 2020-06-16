//
//  YYPasswordView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/22.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYPasswordView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "Masonry.h"
#import "YYSecureView.h"

@interface YYPasswordView ()
<UITextViewDelegate>

@property (nonatomic, strong) YYSecureView *textView;

@end

@implementation YYPasswordView

- (void)dealloc {
    [self.textView removeObserver:self forKeyPath:@"secureContent"];
}

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                            plcStr:(NSString *)plcStr {
    if (self = [super init]) {
        [attackView addSubview:self];
        [self initSubViewsWithTitle:title plcStr:plcStr];
    }
    return self;
}

- (void)initSubViewsWithTitle:(NSString *)title plcStr:(NSString *)plcString {
    self.backgroundColor = COLOR_ffffff;
    
    self.textView = [YYSecureView new];
    self.textView.inputUnitCount = 12; // 最大 12
    self.textView.unitSpace = 3;
    self.textView.secureTextEntry = YES; // 密文
    self.textView.backgroundColor = COLOR_ffffff;
    self.textView.textColor = COLOR_1a1a1a;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.font = FONT_DESIGN_28;
    self.textView.placeholder = plcString;
    self.textView.placeholderColor = COLOR_1a1a1a_A025;
    self.textView.delegate = self;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_110);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-0.5);
        make.height.mas_offset(YYSIZE_40);
    }];
    
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = COLOR_1a1919;
    label.font = FONT_DESIGN_28;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(YYSIZE_22);
        make.centerY.mas_equalTo(self.textView.mas_centerY);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_ebecf0;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, 1));
    }];
    
    [self.textView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"secureContent"]) {
        self.content = self.textView.secureContent;
    }
}

- (void)resignFirstResponder {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}

#pragma mark - textDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.content = textView.text;
}

@end
