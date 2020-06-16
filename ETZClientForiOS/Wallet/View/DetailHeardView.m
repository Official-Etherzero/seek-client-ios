//
//  DetailHeardView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "DetailHeardView.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"
#import "YYInterfaceMacro.h"
#import "RateModel.h"
#import "YYExchangeRateModel.h"

@interface DetailHeardView ()

@property (nonatomic, strong) UILabel *numView;
@property (nonatomic, strong) UILabel *priceView;

@end

@implementation DetailHeardView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *bottomView = [[UIImageView alloc] init];
    [self addSubview:bottomView];
    bottomView.image = [UIImage imageNamed:@"asset_card"];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.numView = [UILabel new];
    self.numView.textAlignment = NSTextAlignmentLeft;
    self.numView.font = FONT_DESIGN_54;
    [self addSubview:self.numView];
    self.numView.text = @"72636222424.63";
    self.numView.textColor = COLOR_ffffff;
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_50);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    self.priceView = [UILabel new];
    self.priceView.textAlignment = NSTextAlignmentLeft;
    self.priceView.font = FONT_DESIGN_26;
    [self addSubview:self.priceView];
    self.priceView.text = [NSString stringWithFormat:@"≈ ¥ %@",@"0"];
    self.priceView.textColor = COLOR_d7ffe8;
    self.priceView.hidden = YES;
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

- (void)setItem:(TokenItem *)item {
    _item = item;
    self.numView.text = [item.num yy_holdDecimalPlaceToIndex:5];
    if (item.num && !([item.num isEqualToString:@"0"])) {
        self.priceView.hidden = NO;
        [self updatePrice];
    }
}

- (void)setRateModels:(NSArray<RateModel *> *)rateModels {
    _rateModels = rateModels;
    [self updatePrice];
}

- (void)updatePrice {
    if (self.rateModels.count > 0 && self.item.num) {
        NSString *price = [YYExchangeRateModel yy_getPriceByModels:self.rateModels balance:self.item.num];
        YYSettingLanguageType type = [[YYLanguageTool shareInstance] currentType];
        switch (type) {
            case YYSettingLanguageTypeChineseSimple: {
                self.priceView.text = [NSString stringWithFormat:@"≈ ¥ %@",[price yy_holdDecimalPlaceToIndex:5]];
            }
                break;
                
            case YYSettingLanguageTypeEnglish:{
                self.priceView.text = [NSString stringWithFormat:@"≈ $ %@",[price yy_holdDecimalPlaceToIndex:5]];
            }
                break;
            case YYSettingLanguageTypeKorea:{
                self.priceView.text = [NSString stringWithFormat:@"≈ ₩ %@",[price yy_holdDecimalPlaceToIndex:5]];
            }
                break;
            default: {
                self.priceView.text = [NSString stringWithFormat:@"≈ $ %@",[price yy_holdDecimalPlaceToIndex:5]];
            }
                break;
        }
    }
}

#pragma mark - notifi
- (void)onNotifyRates:(NSNotification *)notification {
    self.rateModels = notification.userInfo[kExchageRateInfo];
    if (self.rateModels && self.rateModels.count > 0) {
        WDWeakify(self);
        dispatch_async_main_safe(^{
            WDStrongify(self);
            [self updatePrice];
        });
    }
}

@end
