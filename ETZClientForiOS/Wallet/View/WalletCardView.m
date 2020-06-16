//
//  WalletCardView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WalletCardView.h"
#import "YYViewHeader.h"
#import "YYToastView.h"
#import "NSString+Ext.h"
#import "YYInterfaceMacro.h"
#import "RateModel.h"
#import "YYExchangeRateModel.h"

@interface WalletCardView ()

@property (nonatomic, strong) UILabel     *addressLabel;
@property (nonatomic, strong) UILabel     *minerLevelLabel;
@property (nonatomic, strong) UILabel     *totalAssetsLabel;
@property (nonatomic, strong) UIImageView *starView;
@property (nonatomic,   copy) NSArray <RateModel *>* rateModels;

@end

@implementation WalletCardView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyRates:) name:kExchageRate object:nil];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *bottomView = [UIImageView new];
    [self addSubview:bottomView];
    bottomView.image = [UIImage imageNamed:@"card"];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIImageView *starView = [[UIImageView alloc] init];
    [self addSubview:starView];
    starView.image = [UIImage imageNamed:@"VIP"];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_18);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
    }];
    
    // starView 上面放置一个 label,显示 矿工等级
    self.minerLevelLabel = [[UILabel alloc] init];
    [starView addSubview:self.minerLevelLabel];
    self.minerLevelLabel.font = FONT_DESIGN_20;
    self.minerLevelLabel.text = @"LV.22";
    self.minerLevelLabel.textColor = COLOR_26dba5;
    [self.minerLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(starView.mas_left).offset(YYSIZE_26);
        make.bottom.mas_equalTo(starView.mas_bottom).offset(-YYSIZE_07);
    }];
    self.starView = starView;
    
    // totalAssets
    UILabel *titleView = [UILabel new];
    [self addSubview:titleView];
    titleView.text = YYStringWithKey(@"总资产(¥)"); // 这里应该要做一个拼接
    titleView.textColor = COLOR_ccfff0;
    titleView.font = FONT_DESIGN_24;
    titleView.textAlignment = NSTextAlignmentLeft;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
    }];
    
    UILabel *symbolLabel = [UILabel new];
    symbolLabel.textColor = titleView.textColor = COLOR_ccfff0;
    symbolLabel.font = FONT_DESIGN_30;
    symbolLabel.text = @"≈";
    symbolLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:symbolLabel];
    [symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_70);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
    }];
    
    UILabel *totalAssetsLabel = [UILabel new];
    totalAssetsLabel.textColor = COLOR_ffffff;
    totalAssetsLabel.font = FONT_DESIGN_72;
    totalAssetsLabel.text = @"0";
    totalAssetsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:totalAssetsLabel];
    [totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_36);
        make.centerY.mas_equalTo(symbolLabel.mas_centerY);
    }];
    self.totalAssetsLabel = totalAssetsLabel;
    
    self.addressLabel = [UILabel new];
    self.addressLabel.textColor = COLOR_ffffff;
    self.addressLabel.font = FONT_DESIGN_22;
    self.addressLabel.text = @"0xdddf8dsfsdf9sdfsdfs9sdssdfsdf";
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_35);
        make.size.mas_offset(CGSizeMake(YYSIZE_182, YYSIZE_11));
    }];
    
    YYButton *copyBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:copyBtn];
    copyBtn.stretchLength = 5.0f;
    [copyBtn setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressLabel.mas_right).offset(YYSIZE_09);
        make.centerY.mas_equalTo(self.addressLabel.mas_centerY);
    }];
    [copyBtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)copyClick {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.address;
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:[UIApplication sharedApplication].keyWindow];
}

- (void)setModel:(AccountModel *)model {
    _model = model;
    self.addressLabel.text = model.address;
    if (model.balance && ![model.balance isEqualToString:@"0"]) {
        [self updatePrice];
    }
    if (model.level) {
        self.starView.hidden = NO;
        self.minerLevelLabel.text = [NSString stringWithFormat:@"LV.%@",model.level];
    } else {
        self.starView.hidden = YES;
    }
}

- (void)updatePrice {
    if (self.rateModels.count > 0) {
        NSString *price = [YYExchangeRateModel yy_getPriceByModels:self.rateModels balance:self.model.balance];
        self.totalAssetsLabel.text = [price yy_holdDecimalPlaceToIndex:2];
    }
}

#pragma mark - notifi
- (void)onNotifyRates:(NSNotification *)notification {
    self.rateModels = notification.userInfo[kExchageRateInfo];
    if (self.rateModels && self.rateModels.count > 0) {
        dispatch_async_main_safe(^{
            [self updatePrice];
        });
    }
}

@end
