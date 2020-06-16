//
//  YYAlertView.m
//  Video_edit
//
//  Created by yang on 2018/9/30.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYAlertView.h"
#import "YYSize.h"
#import "YYColor.h"
#import "YYFont.h"
#import "Masonry.h"
#import <BlocksKit/BlocksKit.h>

@interface YYAlertView ()
@property(nonatomic, copy) confirmBlock confirmBlock;
@property(nonatomic, copy) cancelBlock  cancelBlock;

@end

@implementation YYAlertView

- (instancetype)initWithAttachView:(UIView *)attachView
                          describe:(NSString *)describe
                      comfirmTitle:(NSString *)comfirmTitle
                       cancelTitle:(NSString *)cancelTitle
                           confirm:(confirmBlock)confirm
                            cancel:(cancelBlock)cancel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [attachView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(attachView);
        }];
        self.confirmBlock = confirm;
        self.cancelBlock = cancel;
        self.backgroundColor = COLOR_000000_A075;
        
        UIView *alertBgView = ({
            UIView *v = [[UIView alloc] init];
            [self addSubview:v];
            v.layer.cornerRadius = 10.0f;
            v.backgroundColor = COLOR_ffca46;
            v.clipsToBounds = YES;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(300, 150));
            }];
            v;
        });
        
        UIView *contentView = ({
            UIView *v = [[UIView alloc] init];
            [alertBgView addSubview:v];
            v.layer.cornerRadius = 10.0f;
            v.backgroundColor = [UIColor whiteColor];
            v.clipsToBounds = YES;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(alertBgView.mas_top).offset(1.0);
                make.left.mas_equalTo(alertBgView.mas_left).offset(6.5);
                make.right.mas_equalTo(alertBgView.mas_right).offset(-6.5);
                make.size.mas_offset(CGSizeMake(287, 146));
            }];
            v;
        });
        
        UIImage *cancle_image = [UIImage imageNamed:@"common_btn_bg"]; // sure_btn_bg  pk_once_again_bg
        UIButton *cancelButton = [self createButtonViewWithFont:FONT_DESIGN_26 backgroundColor:[UIColor blackColor] textColor:[UIColor blackColor] image:cancle_image title:cancelTitle];
        [cancelButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [alertBgView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView).offset(-20);
            make.left.mas_equalTo(contentView).offset(33);
            make.size.mas_equalTo(CGSizeMake(84, 27));
        }];
        
        UIImage *confirm_image = [UIImage imageNamed:@"pk_once_again_bg"];
        UIButton *confirmButton = [self createButtonViewWithFont:FONT_DESIGN_26 backgroundColor:[UIColor blackColor] textColor:[UIColor blackColor] image:confirm_image title:comfirmTitle];
        [confirmButton addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];

        [alertBgView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView).offset(-20);
            make.left.mas_equalTo(cancelButton.mas_right).offset(66);
            make.size.mas_equalTo(CGSizeMake(84, 27));
        }];
        
        UILabel *describeView = [self createLabelViewWithFont:FONT_FZDHTJW_32 textColor:COLOR_1e1e1e text:describe];
        describeView.numberOfLines = 0;
        [alertBgView addSubview:describeView];
        [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(alertBgView.mas_left).offset(20);
            make.top.mas_equalTo(contentView.mas_top);
            make.size.mas_offset(CGSizeMake(260, 130));
        }];
    }
    return self;
}

#pragma mark - pravite

- (UILabel *)createLabelViewWithFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text {
    UILabel *v = [[UILabel alloc] init];
    v.text = text;
    v.font = font;
    v.textColor = color;
    v.textAlignment = NSTextAlignmentLeft;
    return v;
}

- (UIButton *)createButtonViewWithFont:(UIFont *)font backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor image:(UIImage *)image title:(NSString *)title {
    UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
    [v setBackgroundImage:stretchImage forState:UIControlStateNormal];
    [v setTitle:title forState:UIControlStateNormal];
    [v setTitleColor:textColor forState:UIControlStateNormal];
    v.titleLabel.font = font;
    v.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    return v;
}

#pragma mark -  点击事件
- (void)sureBtnClick
{
    [self removeFromSuperview];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)cancleBtnClick
{
    [self removeFromSuperview];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
@end
