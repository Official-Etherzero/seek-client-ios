//
//  TokensCell.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/17.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TokensCell.h"
#import "YYViewHeader.h"
#import "YYWebImage.h"

@interface TokensCell ()

@property (nonatomic, strong) UILabel      *codeLabel;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UIImageView  *headImageView;

@end

@implementation TokensCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews {
    // 左边一个 imageView 上下两个 label，右边一个 button
    self.headImageView = [[UIImageView alloc] init];
    [self addSubview:self.headImageView];
    self.headImageView.image = [UIImage imageNamed:@"head"];
    [self addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_25);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_30, YYSIZE_30));
    }];
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    self.nameLabel.textColor = COLOR_1a1a1a_A05;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(YYSIZE_11);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.codeLabel = [UILabel new];
    [self addSubview:self.codeLabel];
    self.codeLabel.textColor = COLOR_1a1a1a_A05;
    self.codeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(YYSIZE_11);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:YYStringWithKey(@"添加") forState:UIControlStateNormal];
    addBtn.titleLabel.textColor = COLOR_1a1a1a_A05;
    [addBtn.titleLabel setFont:FONT_DESIGN_24];
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-YYSIZE_11);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [addBtn addTarget:self action:@selector(addTokenClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTokenClick {
    if (self.addTokenBlock) {
        self.addTokenBlock(self.model);
    }
}

- (void)setModel:(TokenModel *)model {
    _model = model;
}



@end
