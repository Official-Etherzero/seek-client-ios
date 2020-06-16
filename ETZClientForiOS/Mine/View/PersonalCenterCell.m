//
//  PersonalCenterCell.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PersonalCenterCell.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"

@interface PersonalCenterCell ()

@property(nonatomic, strong, readwrite) UIImageView  *titleView;
@property(nonatomic, strong, readwrite) UIImageView  *arrowView;
@property(nonatomic, strong, readwrite) UILabel      *titleLabel;
@property(nonatomic, strong, readwrite) UILabel      *desLabel;
@property(nonatomic, strong, readwrite) UIView       *separatorView;
@property(nonatomic, strong, readwrite) UIButton     *checkBtn;

@end

@implementation PersonalCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_ffffff;
        
        self.separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        self.separatorView.backgroundColor = COLOR_d4d4d4;
        [self addSubview:self.separatorView];
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_21);
            make.right.mas_equalTo(self).offset(-YYSIZE_21);
            make.bottom.mas_equalTo(self).offset(-1);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

+ (NSString *)identifier {
    return @"PersonalCenterCell";
}

#pragma mark -property


- (void)setModel:(SettingRowModel *)model {
    _model = model;
    self.titleLabel.text = YYStringWithKey(model.title);
    [self addSubview:self.titleLabel];
    switch (model.rowType) {
        case WDSettingRowTypeCustome: {
            [self.titleLabel removeFromSuperview];
        }
            break;
        case WDSettingRowTypeArrow: {
            if (model.imageName && model.imageName.length > 0) {
                self.titleView.image = [UIImage imageNamed:model.imageName];
                [self addSubview:self.titleView];
                [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.mas_left).offset(YYSIZE_21);
                    make.centerY.mas_equalTo(self.mas_centerY);
                    make.size.mas_offset(CGSizeMake(YYSIZE_20, YYSIZE_20));
                }];
                
                [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.titleView.mas_right).offset(YYSIZE_15);
                    make.centerY.mas_equalTo(self.mas_centerY);
                }];
            } else {
                [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self).offset(YYSIZE_22);
                    make.centerY.mas_equalTo(self.mas_centerY);
                }];
            }
            
            self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_btn"]];
            [self addSubview:self.arrowView];
            [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_21);
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
        }
            break;
        case WDSettingRowTypeDescArrow: {
            [self addSubview:self.arrowView];
            [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).offset(-YYSIZE_21);
                make.height.mas_equalTo(self);
            }];
        }
            break;
        case WDSettingRowTypeDesc: {
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(YYSIZE_22);
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
            if (!self.desLabel) {
                self.desLabel = ({
                    UILabel *v = [UILabel new];
                    v.textAlignment = NSTextAlignmentLeft;
                    v.textColor = COLOR_1a1a1a_A025;
                    v.font = FONT_DESIGN_28;
                    v;
                });
                [self addSubview:self.desLabel];
                [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self).offset(YYSIZE_117);
                    make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_50);
                    make.centerY.mas_equalTo(self.mas_centerY);
                }];
            }
            self.desLabel.text = model.desc;
            break;
        }
        case WDSettingRowTypeCheckbox: {
            [self addSubview:self.checkBtn];
            self.checkBtn.userInteractionEnabled = NO;
            [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.size.mas_offset(CGSizeMake(YYSIZE_20, YYSIZE_20));
            }];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.checkBtn.mas_right).offset(YYSIZE_08);
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
            self.checkBtn.selected = _model.selected;
             _titleLabel.textColor = _model.selected ? COLOR_30D1A1 : COLOR_1a1a1a;
            break;
        }
        case WDSettingRowTypeNone:
            break;
    }
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_btn"]];
        _arrowView.contentMode = UIViewContentModeCenter;
    }
    return _arrowView;
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
            btn.contentMode = UIViewContentModeCenter;
            btn;
        });
    }
    return _checkBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = COLOR_1a1a1a;
        _titleLabel.font = FONT_DESIGN_28;
    }
    return _titleLabel;
}

- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] init];
    }
    return _titleView;
}

@end
