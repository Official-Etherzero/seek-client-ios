//
//  TokenCell.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TokenCell.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"
#import "YYInterfaceMacro.h"
#import "RateModel.h"
#import "YYExchangeRateModel.h"

@interface TokenCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleView;
@property (nonatomic, strong) UILabel     *codeView;
@property (nonatomic, strong) UILabel     *numView;
@property (nonatomic, strong) UILabel     *priceView;
@property (nonatomic,   copy) NSArray <RateModel *>* rateModels;

@end

@implementation TokenCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyRates:) name:kExchageRate object:nil];
    }
    return self;
}

- (void)initSubViews {
    self.imageView = [UIImageView new];
    self.imageView.image = [UIImage imageNamed:@""];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_23);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_37, YYSIZE_37));
    }];
    
    self.titleView = [self createCustomLabel];
    self.titleView.textColor = COLOR_1a1a1a;
    self.titleView.font = FONT_DESIGN_36;
    self.titleView.textAlignment = NSTextAlignmentLeft;
    self.titleView.text = @"SEEK";
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_12);
        make.top.mas_equalTo(self.imageView.mas_top);
    }];
    
    self.codeView = [self createCustomLabel];
    self.codeView.textColor = COLOR_1a1a1a_A04;
    self.codeView.font = FONT_DESIGN_24;
    self.codeView.text = @"Seekchian";
    self.codeView.textAlignment = NSTextAlignmentLeft;
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_12);
//        make.top.mas_equalTo(self.titleView.mas_bottom).offset(11);
        make.bottom.mas_equalTo(self.imageView.mas_bottom);
    }];
    
    self.numView = [self createCustomLabel];
    self.numView.textColor = COLOR_1a1a1a;
    self.numView.font = FONT_DESIGN_36;
    self.numView.text = @"95";
    self.numView.textAlignment = NSTextAlignmentRight;
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_17);
        make.top.mas_equalTo(self.imageView.mas_top);
        make.width.mas_offset(YYSIZE_150);
    }];
    
    self.priceView = [self createCustomLabel];
    self.priceView.textColor = COLOR_1a1a1a_A04;
    self.priceView.font = FONT_DESIGN_24;
    self.priceView.textAlignment = NSTextAlignmentRight;
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_17);
//        make.top.mas_equalTo(self.numView.mas_bottom).offset(8);
        make.bottom.mas_equalTo(self.imageView.mas_bottom);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_ebecf0;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, 1));
    }];
    
}

- (UILabel *)createCustomLabel {
    UILabel *l = [UILabel new];
    [self addSubview:l];
    return l;
}

- (void)setItem:(TokenItem *)item {
    _item = item;
    self.titleView.text = item.name;
    self.codeView.text = item.code;
    self.imageView.image = [UIImage imageNamed:item.imageUrl];
    self.numView.text = [item.num yy_holdDecimalPlaceToIndex:5];
    if (item.num && !([item.num isEqualToString:@"0"])) {
        self.priceView.hidden = NO;
        [self updatePrice];
    } else {
        self.priceView.hidden = YES;
    }
}

- (void)updatePrice {
    if (self.rateModels.count > 0 && ![self.item.num isEqualToString:@"0"]) {
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
        dispatch_async_main_safe(^{
            [self updatePrice];
        });
    }
}

@end
