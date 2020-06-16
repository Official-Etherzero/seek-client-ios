//
//  PersonWalletCell.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PersonWalletCell.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"

// height 133
@interface PersonWalletCell ()

@property (nonatomic, strong) UIImageView   *leftView;
@property (nonatomic, strong) UIImageView   *rightView;
@property (nonatomic, strong) UILabel       *addressLabel;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *balanceLabel;

@end

@implementation PersonWalletCell

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"balance"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.leftView = [self creatImageView];
    self.leftView.image = [UIImage imageNamed:@"person_header"];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(YYSIZE_22);
        make.top.mas_equalTo(self).offset(YYSIZE_25);
        make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_40));
    }];
    
    self.rightView = [self creatImageView];
    self.rightView.image = [UIImage imageNamed:@"Arrow_btn"];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-YYSIZE_22);
        make.top.mas_equalTo(self.leftView).offset(YYSIZE_14);
    }];
    
    self.titleLabel = [self createLabel];
    self.titleLabel.textColor = COLOR_1a1a1a;
    [self.titleLabel setFont:FONT_PingFangSC_BLOD_30];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftView);
        make.left.mas_equalTo(self.leftView.mas_right).offset(YYSIZE_12);
        make.right.mas_equalTo(self).offset(-YYSIZE_50);
    }];
    
    self.addressLabel = [self createLabel];
    self.addressLabel.textColor = COLOR_1a1a1a_A06;
    [self.addressLabel setFont:FONT_DESIGN_22];
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.leftView);
        make.left.mas_equalTo(self.leftView.mas_right).offset(YYSIZE_12);
        make.size.mas_offset(CGSizeMake(YYSIZE_114, YYSIZE_09));
    }];
    
    self.balanceLabel = [self createLabel];
    self.balanceLabel.textColor = COLOR_1a1a1a;
    self.balanceLabel.textAlignment = NSTextAlignmentRight;
    [self.balanceLabel setFont:FONT_PingFangSC_BLOD_30];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-YYSIZE_22);
        make.top.mas_equalTo(self.rightView.mas_bottom).offset(YYSIZE_36);
        make.width.mas_offset(YYSIZE_200);
    }];
    self.balanceLabel.text = [NSString stringWithFormat:@"0 SEEK"];
    
    UIView *separatorView = [UIView new];
    [self addSubview:separatorView];
    separatorView.backgroundColor = COLOR_f5f8fa;
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_10));
    }];
}

- (UIImageView *)creatImageView {
    UIImageView *v = [UIImageView new];
    [self addSubview:v];
    return v;
}

- (UILabel *)createLabel {
    UILabel *v = [UILabel new];
    v.textAlignment = NSTextAlignmentLeft;
    [self addSubview:v];
    return v;
}

- (void)setModel:(AccountModel *)model {
    _model = model;
    self.addressLabel.text = model.address;
    self.titleLabel.text = model.userName;
    [_model addObserver: self forKeyPath: @"balance" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"balance"]) {
        NSString *str = [_model.balance yy_holdDecimalPlaceToIndex:5];
        self.balanceLabel.text = [NSString stringWithFormat:@"%@ SEEK",str];
    }
}

- (void)setBalance:(NSString *)balance {
    self.balanceLabel.text = [NSString stringWithFormat:@"%@ SEEK",balance];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
