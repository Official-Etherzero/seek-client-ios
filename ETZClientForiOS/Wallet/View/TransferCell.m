//
//  TransferCell.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TransferCell.h"
#import "YYViewHeader.h"
#import "WalletDataManager.h"
#import "YYDateModel.h"
#import "YYCalculateModel.h"
#import "NSString+Ext.h"

@interface TransferCell ()

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UILabel      *addressLabel;
@property (nonatomic, strong) UILabel      *dateLabel;
@property (nonatomic, strong) UILabel      *amountLabel;
@property (nonatomic, strong) UILabel      *statusLabel;

@end


@implementation TransferCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.imageView = [UIImageView new];
    self.imageView.image = [UIImage imageNamed:@"shoukuan-1"];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_23);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_17, YYSIZE_17));
    }];

    self.addressLabel = [self createCustomLabel];
    self.addressLabel.textColor = COLOR_1a1a1a;
    self.addressLabel.font = FONT_DESIGN_30;
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.addressLabel.text = @"0x1edjnfsdjf233242304isdf";
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_12);
        make.bottom.mas_equalTo(self.mas_centerY).offset(YYSIZE_03);
        make.width.mas_offset(YYSIZE_128);
    }];

    self.dateLabel = [self createCustomLabel];
    self.dateLabel.textColor = COLOR_1a1a1a_A04;
    self.dateLabel.font = FONT_DESIGN_24;
    self.dateLabel.text = @"Seekchian";
    self.dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(YYSIZE_12);
        //        make.top.mas_equalTo(self.titleView.mas_bottom).offset(11);
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(YYSIZE_06);
    }];

    self.amountLabel = [self createCustomLabel];
    self.amountLabel.textColor = COLOR_1a1a1a;
    self.amountLabel.font = FONT_DESIGN_36;
    self.amountLabel.text = @"95";
    self.amountLabel.textAlignment = NSTextAlignmentRight;
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_17);
        make.bottom.mas_equalTo(self.mas_centerY).offset(YYSIZE_03);
    }];

    self.statusLabel = [self createCustomLabel];
    self.statusLabel.textColor = COLOR_1a1a1a_A04;
    self.statusLabel.font = FONT_DESIGN_24;
    self.statusLabel.text = @"89.5";
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_17);
        //        make.top.mas_equalTo(self.numView.mas_bottom).offset(8);
        make.top.mas_equalTo(self.amountLabel.mas_bottom).offset(YYSIZE_06);
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

- (void)setItem:(TransferItem *)item {
    _item = item;
    self.addressLabel.text = [[WalletDataManager accountModel].address isEqualToString:[item.from lowercaseString]] ? [item.to lowercaseString] : [item.from lowercaseString];
    long long num = 4701945600;
    if (item.timestamp > num) {
        NSString *timeStr = [item.timeStamp substringToIndex:10];
        double t = [timeStr doubleValue];
        self.dateLabel.text = [YYDateModel yy_getTimeFromTimeStamp:t];
    } else {
        self.dateLabel.text = [YYDateModel yy_getTimeFromTimeStamp:item.timestamp];
    }
    
    NSString *valueString = [[YYCalculateModel yy_calculateDividedWithNumString:item.value] yy_holdDecimalPlaceToIndex:5];
    if ([[WalletDataManager accountModel].address isEqualToString:[item.from lowercaseString]]) {
        self.amountLabel.text = [NSString stringWithFormat:@"-%@ SEEK",valueString];
    } else {
        self.amountLabel.text = [NSString stringWithFormat:@"+%@ SEEK",valueString];
    }
    
    if ([item.blockNumber isEqualToString:@"null"]
        || item.blockHash == nil) {
        // 交易进行中
        self.statusLabel.textColor = COLOR_1a1a1a_A04;
        self.statusLabel.text = YYStringWithKey(@"交易进行中");
        self.imageView.image = [UIImage imageNamed:@"jinxingzhong"];
    } else {
        if (!item.to || [item.status isEqualToString:@"fail"]) {
            self.statusLabel.textColor = COLOR_ff5959;
            self.statusLabel.text = YYStringWithKey(@"交易失败");
            self.imageView.image = [UIImage imageNamed:@"wrong"];
        } else {
            self.statusLabel.textColor = COLOR_1a1a1a_A04;
            self.statusLabel.text = YYStringWithKey(@"交易成功");
            NSString *imageStr = [[WalletDataManager accountModel].address isEqualToString:[item.from lowercaseString]] ? @"zhuanzhang-1" : @"shoukuan-1";
            self.imageView.image = [UIImage imageNamed:imageStr];
        }
    }
}


@end
