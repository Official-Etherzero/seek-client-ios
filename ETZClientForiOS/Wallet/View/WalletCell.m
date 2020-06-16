//
//  WalletCell.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WalletCell.h"
#import "YYViewHeader.h"

@interface WalletCell ()

@property (nonatomic, strong) UIImageView  *imgView;
@property (nonatomic, strong) UILabel      *userView;

@end

@implementation WalletCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    self.imgView.image = [UIImage imageNamed:@"head"];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_25);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_30, YYSIZE_30));
    }];
    
    self.userView = [UILabel new];
    [self addSubview:self.userView];
    self.userView.textColor = COLOR_1a1a1a_A05;
    self.userView.textAlignment = NSTextAlignmentLeft;
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(YYSIZE_11);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.userView.textColor = COLOR_1a1a1a;
        self.imgView.image = [UIImage imageNamed:@"head_sel"];
    } else {
        self.imgView.image = [UIImage imageNamed:@"head"];
        self.userView.textColor = COLOR_1a1a1a_A05;
    }
}

- (void)setModel:(AccountModel *)model {
    _model = model;
    self.userView.text = model.userName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
