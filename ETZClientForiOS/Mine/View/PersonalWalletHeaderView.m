//
//  PersonalWalletHeaderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PersonalWalletHeaderView.h"
#import "YYViewHeader.h"

@implementation PersonalWalletHeaderView

- (instancetype)initWithAddress:(NSString *)address
                         amount:(NSString *)amount {
    if (self = [super init]) {
        UIImageView *headerView = [[UIImageView alloc] init];
        [self addSubview:headerView];
        headerView.image = [UIImage imageNamed:@"person_header"];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self).offset(YYSIZE_25);
            make.size.mas_offset(CGSizeMake(YYSIZE_50, YYSIZE_50));
        }];
        
        UILabel *addressView = [UILabel new];
        addressView.textAlignment = NSTextAlignmentCenter;
        addressView.textColor = COLOR_1a1a1a_A04;
        addressView.text = address;
        addressView.font = FONT_DESIGN_24;
        [self addSubview:addressView];
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(headerView.mas_bottom).offset(YYSIZE_10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        UILabel *amoutView = [UILabel new];
        amoutView.textAlignment = NSTextAlignmentCenter;
        amoutView.textColor = COLOR_1a1a1a;
        amoutView.text = [NSString stringWithFormat:@"%@ SEEK",amount];
        amoutView.font = FONT_PingFangSC_BLOD_32;
        [self addSubview:amoutView];
        [amoutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(addressView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return self;
}


@end
