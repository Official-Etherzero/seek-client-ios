//
//  TokenHeaderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TokenHeaderView.h"
#import "YYViewHeader.h"

@interface TokenHeaderView ()

@end

@implementation TokenHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = FONT_DESIGN_44;
    label.textColor = COLOR_1a1a1a;
    label.text = YYStringWithKey(@"资产");
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.centerY.mas_equalTo(self.mas_centerY).offset(YYSIZE_10);
    }];
    
    YYButton *addButton = [YYButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:addButton];
    addButton.stretchLength = 5.0f;
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        make.centerY.mas_equalTo(self.mas_centerY).offset(YYSIZE_10);
    }];
    addButton.enabled = NO;
    [addButton addTarget:self action:@selector(addTokenClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTokenClick {
    if (self.addTokenBlock) {
        self.addTokenBlock();
    }
}


@end
