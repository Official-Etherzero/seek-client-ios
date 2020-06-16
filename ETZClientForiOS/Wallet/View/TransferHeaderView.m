//
//  TransferHeaderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TransferHeaderView.h"
#import "YYViewHeader.h"


@implementation TransferHeaderView

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
    label.text = YYStringWithKey(@"交易记录");
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.centerY.mas_equalTo(self.mas_centerY).offset(YYSIZE_10);
    }];
}

@end
