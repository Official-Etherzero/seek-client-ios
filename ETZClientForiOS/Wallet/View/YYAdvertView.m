//
//  YYAdvertView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYAdvertView.h"
#import "YYViewHeader.h"

@implementation YYAdvertView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"banner"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_22);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
    }];
    [deleteBtn setImage:[UIImage imageNamed:@"banner_close"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnDidClick {
    if ([self.delegate respondsToSelector:@selector(yy_hideAdvertView)]) {
        [self.delegate yy_hideAdvertView];
    }
}

@end
