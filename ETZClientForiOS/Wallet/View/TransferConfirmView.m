//
//  TransferConfirmView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TransferConfirmView.h"
#import "YYPlaceholderView.h"
#import "YYViewHeader.h"

@interface TransferConfirmView ()

@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation TransferConfirmView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = COLOR_ffffff;
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backButton];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_19);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_22, YYSIZE_22));
    }];
    [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [UILabel new];
    [self addSubview:label];
    label.text = YYStringWithKey(@"输入密码");
    label.textColor = COLOR_a1a1a1;
    label.font = FONT_PingFangSC_Medium_32;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_ebecf0;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(1);
        make.left.right.mas_equalTo(self);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 1));
    }];
    
    self.inputPawView = [[YYPasswordView alloc] initWithAttackView:self title:YYStringWithKey(@"支付密码") plcStr:YYStringWithKey(@"请输入支付密码")];
    [self.inputPawView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(YYSIZE_64);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    YYButton *confirmButton = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:confirmButton];
    confirmButton.stretchLength = 5.0f;
    [confirmButton.titleLabel setFont:FONT_DESIGN_30];
    [confirmButton setBackgroundColor:COLOR_30D1A1];
    [confirmButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [confirmButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [confirmButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    confirmButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [confirmButton.layer setMasksToBounds:YES];
    confirmButton.layer.cornerRadius = 5.0f;
    [confirmButton setTitle:YYStringWithKey(@"确认支付") forState:UIControlStateNormal];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_135);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_47));
    }];
    [confirmButton addTarget:self action:@selector(confirmPayClick:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton = confirmButton;
}

- (void)setConfirButtonEnable:(BOOL)enable {
    self.confirmButton.enabled = enable;
}

- (void)confirmPayClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(yy_confirmPayClickAction)]) {
        [self.delegate yy_confirmPayClickAction];
    }
}

- (void)backClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(yy_returnPayDetailView)]) {
        [self.delegate yy_returnPayDetailView];
    }
}

@end
