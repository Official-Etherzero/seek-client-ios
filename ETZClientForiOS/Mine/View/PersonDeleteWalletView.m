//
//  PersonDeleteWalletView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/10.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PersonDeleteWalletView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "UILabel+Ext.h"
#import "YYLabel.h"

@implementation PersonDeleteWalletView

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
    
    YYLabel *contentLabel = [YYLabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = COLOR_1a1a1a;
    contentLabel.font = FONT_DESIGN_24;
    contentLabel.text = YYStringWithKey(@"请确认已经备份好钱包私钥、助记词或者Keystore，否则删除钱包后将无法恢复。");
    [contentLabel yy_setSpacewithLineSpace:10 wordSpace:0];
    NSInteger lines = [contentLabel yy_needLinesByWidth:YYSIZE_230];
    CGFloat labelHeight = [contentLabel getHeightByWidth:YYSIZE_230 title:contentLabel.text font:FONT_DESIGN_24] + (lines -1) * 10;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.backgroundColor = COLOR_ffffff;
    bottomView.layer.cornerRadius = 10;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_191 + labelHeight));
    }];
    
    UIImageView *imageView = [UIImageView new];
    [bottomView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"jinggao"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(YYSIZE_40);
        make.left.mas_equalTo(bottomView).offset(YYSIZE_74);
        make.size.mas_offset(CGSizeMake(YYSIZE_30, YYSIZE_30));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = YYStringWithKey(@"风险提示");
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = COLOR_1a1a1a;
    titleLabel.font = FONT_PingFangSC_Heavy_44;
    [bottomView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView).offset(YYSIZE_110);
        make.centerY.mas_equalTo(imageView.mas_centerY);
    }];
    
    [bottomView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(YYSIZE_90);
//        make.left.mas_equalTo(bottomView).offset(YYSIZE_25);
        make.centerX.mas_equalTo(bottomView);
        make.width.mas_offset(YYSIZE_230);
    }];
    
    UIButton *confrimBtn = [self createCustomButton];
    confrimBtn.layer.cornerRadius = 2.0f;
    [confrimBtn setTitle:YYStringWithKey(@"确认删除") forState:UIControlStateNormal];
    [confrimBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [confrimBtn setBackgroundColor:COLOR_30D1A1];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(YYSIZE_30);
        make.size.mas_offset(CGSizeMake(YYSIZE_200, YYSIZE_30));
    }];
    [confrimBtn addTarget:self action:@selector(confrimClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 191 + label
}

- (void)confrimClick {
    if (self.confirmDeleteBlock) {
        self.confirmDeleteBlock();
    }
}

- (UIButton *)createCustomButton {
    UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
    v.titleLabel.textAlignment = NSTextAlignmentCenter;
    v.titleLabel.font = FONT_DESIGN_26;
    [self addSubview:v];
    return v;
}

@end
