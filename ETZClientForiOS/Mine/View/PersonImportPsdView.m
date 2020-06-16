//
//  PersonImportPsdView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/10.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PersonImportPsdView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"

@interface PersonImportPsdView ()

@property (nonatomic, strong) YYSecureView *textView;
@property (nonatomic,   copy) NSString     *textContent;

@end

@implementation PersonImportPsdView

- (void)dealloc {
    [self.textView removeObserver:self forKeyPath:@"secureContent"];
}

- (instancetype)init {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A06;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.backgroundColor = COLOR_ffffff;
    bottomView.layer.cornerRadius = 10;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_132));
    }];
    
    self.textView = [YYSecureView new];
    [bottomView addSubview:self.textView];
    self.textView.inputUnitCount = 12; // 最大 12
    self.textView.unitSpace = 3;
    self.textView.secureTextEntry = YES; // 密文
    self.textView.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 2.0;
    self.textView.textAlignment = NSTextAlignmentCenter;
    [self.textView setFont:FONT_DESIGN_24];
    self.textView.placeholder = YYStringWithKey(@"请输入密码");
    self.textView.alignment = NSTextAlignmentCenter;
    self.textView.placeholderColor = COLOR_1a1a1a_A05;
    self.textView.textColor = COLOR_1a1a1a;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(YYSIZE_31);
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_201, YYSIZE_31));
    }];
    [self.textView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
    
    UIButton *cancelBtn = [self createCustomButton];
    [cancelBtn.layer setBorderWidth:1];
    [cancelBtn.layer setBorderColor:COLOR_30D1A1.CGColor];
    [cancelBtn.layer setMasksToBounds:YES];
    [cancelBtn setTitle:YYStringWithKey(@"取消") forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_30D1A1 forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:COLOR_ffffff];
    cancelBtn.layer.cornerRadius = 2.0f;
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textView.mas_left);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
    }];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confrimBtn = [self createCustomButton];
    confrimBtn.layer.cornerRadius = 2.0f;
    [confrimBtn setTitle:YYStringWithKey(@"确认") forState:UIControlStateNormal];
    [confrimBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [confrimBtn setBackgroundColor:COLOR_30D1A1];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textView);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
    }];
    [confrimBtn addTarget:self action:@selector(confrimClick) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)createCustomButton {
    UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
    v.titleLabel.textAlignment = NSTextAlignmentCenter;
    v.titleLabel.font = FONT_DESIGN_26;
    [self addSubview:v];
    return v;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"secureContent"]) {
        self.textContent = self.textView.secureContent;
    }
}

#pragma mark -

- (void)cancelClick {
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
}

- (void)confrimClick {
    if (self.confirmClickBlock) {
        self.confirmClickBlock(self.textContent);
    }
}


@end
