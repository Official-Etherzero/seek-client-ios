//
//  TransferBottomView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TransferBottomView.h"
#import "YYViewHeader.h"

@interface TransferBottomView ()

@property (nonatomic, strong) UIButton *transferBtn;
@property (nonatomic, strong) UIButton *collectionBtn;

@end

@implementation TransferBottomView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews {
    self.transferBtn = [self createCustomButton];
    [self.transferBtn.layer setBorderWidth:1];
    [self.transferBtn.layer setBorderColor:COLOR_30D1A1.CGColor];
    [self.transferBtn.layer setMasksToBounds:YES];
    [self.transferBtn setTitle:YYStringWithKey(@"转账") forState:UIControlStateNormal];
    [self.transferBtn setTitleColor:COLOR_30D1A1 forState:UIControlStateNormal];
    [self.transferBtn setBackgroundColor:COLOR_ffffff];
    self.transferBtn.layer.cornerRadius = 5.0f;
    
    [self.transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_42));
    }];
    [self.transferBtn addTarget:self action:@selector(transferClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectionBtn = [self createCustomButton];
    self.collectionBtn.layer.cornerRadius = 5.0f;
    [self.collectionBtn setTitle:YYStringWithKey(@"收款") forState:UIControlStateNormal];
    [self.collectionBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.collectionBtn setBackgroundColor:COLOR_30D1A1];
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_42));
    }];
    [self.collectionBtn addTarget:self action:@selector(colloctionClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)colloctionClick {
    if ([self.delegate respondsToSelector:@selector(yy_openCollectionController)]) {
        [self.delegate yy_openCollectionController];
    }
}

- (void)transferClick {
    if ([self.delegate respondsToSelector:@selector(yy_openTransferController)]) {
        [self.delegate yy_openTransferController];
    }
}

- (UIButton *)createCustomButton {
    UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
    v.titleLabel.textAlignment = NSTextAlignmentCenter;
    v.titleLabel.font = FONT_DESIGN_30;
    [self addSubview:v];
    return v;
}

@end
