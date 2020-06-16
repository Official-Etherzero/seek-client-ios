//
//  WalletHeaderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WalletHeaderView.h"
#import "YYViewHeader.h"
#import "WalletCardView.h"
#import "ImageCenterButton.h"
#import "WalletDataManager.h"

@interface WalletHeaderView ()

@property (nonatomic, strong) WalletCardView *cardView;

@end

@implementation WalletHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UILabel *walletLabel = [UILabel new];
    [self addSubview:walletLabel];
    walletLabel.text = YYStringWithKey(@"我的钱包");
    walletLabel.font = FONT_DESIGN_42;
    walletLabel.textAlignment = NSTextAlignmentLeft;
    [walletLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_44);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
    }];
    
    YYButton *listButton = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:listButton];
    listButton.stretchLength = 8.0f;
    [listButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [listButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_44);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_24);
    }];
    [listButton addTarget:self action:@selector(moreWalletClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cardView = [[WalletCardView alloc] init];
    [self addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(listButton.mas_bottom).offset(YYSIZE_17);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_164));
    }];
    
    NSArray *titles = [WalletDataManager funcTitles];
    NSArray *images = [WalletDataManager funcImages];
    
    UIButton *lastView = nil;
    for (int i = 0; i < titles.count; i++) {
        NSString *_t = titles[i];
        NSString *_img = images[i];
        UILabel *label = [UILabel new];
        label.textColor = COLOR_1a1a1a;
        label.font = FONT_DESIGN_24;
        label.text = YYStringWithKey(_t);
        YYButton *btn = ({
            YYButton *v = [YYButton buttonWithType:UIButtonTypeCustom];
            v.tag = i;
            [v setImage:[UIImage imageNamed:_img] forState:UIControlStateNormal];
            [v addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:v];
            v.stretchLength = 5.0f;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.cardView.mas_bottom).offset(YYSIZE_23);
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(YYSIZE_57);
                } else {
                    make.left.mas_equalTo(self.mas_left).offset(YYSIZE_45);
                }
            }];
            lastView = v;
            v;
        });
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(btn);
            make.top.mas_equalTo(btn.mas_bottom).offset(3);
        }];
    }
}

- (void)moreWalletClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(yy_openWalletListViewControler)]) {
        [self.delegate yy_openWalletListViewControler];
    }
}

- (void)functionBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(yy_functionClickWithCurrentIndex:)]) {
        [self.delegate yy_functionClickWithCurrentIndex:btn.tag];
    }
}

- (void)setModel:(AccountModel *)model {
    _model = model;
    self.cardView.model = model;
}



@end
