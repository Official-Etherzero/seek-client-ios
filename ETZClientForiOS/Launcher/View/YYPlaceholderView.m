//
//  YYPlaceholderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYPlaceholderView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "Masonry.h"

@interface YYPlaceholderView ()
<UITextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UILabel    *contentLabel;

@end

@implementation YYPlaceholderView

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
    
    self.textView = [YYTextView new];
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
}

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                           content:(NSString *)content {
    if (self = [super init]) {
        [attackView addSubview:self];
        self.backgroundColor = COLOR_ffffff;
        
        UILabel *contentView = [UILabel new];
        contentView.textColor = COLOR_1a1a1a;
        contentView.textAlignment = NSTextAlignmentLeft;
        contentView.numberOfLines = 0;
        contentView.font = FONT_DESIGN_28;
        [self addSubview:contentView];
        contentView.text = content;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_95);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-0.5);
            make.height.mas_offset(YYSIZE_40);
        }];
        self.contentLabel = contentView;
        
        UILabel *label = [UILabel new];
        label.text = title;
        label.textColor = COLOR_1a1919;
        label.font = FONT_DESIGN_28;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_22);
            make.centerY.mas_equalTo(contentView.mas_centerY);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 1));
        }];
    }
    return self;
}

- (void)resignFirstResponder {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.textView.text = content;
}

- (void)setDesString:(NSString *)desString {
    _desString = desString;
    self.contentLabel.text = desString;
}

#pragma mark - textDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.content = textView.text;
}

@end
