//
//  YYImportWalletView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/21.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYImportWalletView.h"
#import "YYPlaceholderView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "YYToastView.h"
#import "YYPasswordView.h"

@interface YYImportWalletView ()

@property (nonatomic, strong) YYTextView        *textView;
@property (nonatomic, strong) YYPlaceholderView *nameView;
@property (nonatomic, strong) YYPasswordView    *inputPswView;
@property (nonatomic, strong) YYPasswordView    *confirmPswView;
@property (nonatomic, strong) UIButton          *importButton;
@property (nonatomic,   copy) NSString          *desStr;
@property (nonatomic, strong) YYImportInfo      *info;

@end

@implementation YYImportWalletView

- (instancetype)initWithAttackView:(UIView *)attackView info:(nonnull YYImportInfo *)info desStr:(nonnull NSString *)desStr {
    if (self = [super init]) {
        [attackView addSubview:self];
        self.desStr = desStr;
        self.info = info;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(attackView);
            if (@available(iOS 11.0, *)) {
                make.top.mas_equalTo(attackView.mas_safeAreaLayoutGuideTop).offset(YYSIZE_42);
                make.bottom.mas_equalTo(attackView.mas_safeAreaLayoutGuideBottom);
            } else {
                make.top.mas_equalTo(attackView.mas_top).offset(YYSIZE_106);
                make.bottom.mas_equalTo(attackView.mas_bottom);
            }
        }];
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(YYImportStyle)style desStr:(NSString *)desStr {
    if (self = [super initWithFrame:frame]) {
        self.desStr = desStr;
        self.info.style = style;
        [self initSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard) name:@"KShowKeyboard" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSubViews {
    // textView
    
    self.textView = [YYTextView new];
    [self addSubview:self.textView];
    self.textView.layer.borderColor = COLOR_1a1a1a.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 5.0;
//    self.textView.textAlignment = NSTextAlignmentLeft;
    [self.textView setFont:FONT_DESIGN_28];
    self.textView.textContainerInset = UIEdgeInsetsMake(15, 16, 15,16);
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_28);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_140));
    }];
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 14;
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
    self.textView.placeholder = self.desStr;
//    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.desStr attributes:attributes];
    
    // YYTextView
    self.nameView = [[YYPlaceholderView alloc] initWithAttackView:self title:YYStringWithKey(@"钱包备注") plcStr:YYStringWithKey(@"请输入钱包备注")];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.inputPswView = [[YYPasswordView alloc] initWithAttackView:self title:YYStringWithKey(@"钱包密码") plcStr:YYStringWithKey(@"请输入钱包密码")];
    [self.inputPswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.confirmPswView = [[YYPasswordView alloc] initWithAttackView:self title:YYStringWithKey(@"确认密码") plcStr:YYStringWithKey(@"请确认钱包密码")];
    [self.confirmPswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputPswView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    // Button
    self.importButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.importButton];
    [self.importButton.titleLabel setFont:FONT_DESIGN_30];
    [self.importButton setBackgroundColor:COLOR_30D1A1];
    [self.importButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.importButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.importButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.importButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.importButton.layer setMasksToBounds:YES];
    self.importButton.layer.cornerRadius = 5.0f;
    [self.importButton setTitle:YYStringWithKey(@"导入钱包") forState:UIControlStateNormal];
    [self.importButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(216);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.importButton addTarget:self action:@selector(importWalletClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showKeyboard {
    [self.textView resignFirstResponder];
    [self.nameView resignFirstResponder];
    [self.inputPswView resignFirstResponder];
    [self.confirmPswView resignFirstResponder];
}

- (void)importWalletClick:(UIButton *)btn {
    // 输入框不能为空
    if (self.textView && self.textView.text.length == 0) {
        switch (self.info.style) {
            case YYImportMnemonic:{
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入您要导入的助记词") attachedView:[UIApplication sharedApplication].keyWindow];
                return;
            }
            case YYImportPrivateKey:{
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入您要导入的私钥") attachedView:[UIApplication sharedApplication].keyWindow];
                return;
            }
            case YYImportKeystore:{
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入您要导入的Keystore") attachedView:[UIApplication sharedApplication].keyWindow];
                return;
            }
            default:
                break;
        }
        return;
    }
    // 备注不能为空
    if (!self.nameView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入备注") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    // 密码不能为空
    if (!self.inputPswView.content || !self.confirmPswView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    // 密码得正确
    if (![self.inputPswView.content isEqualToString:self.confirmPswView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码不正确") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    self.info.name = self.nameView.content;
    self.info.psw = self.inputPswView.content;
    self.info.content = self.textView.text;
    if ([self.delegate respondsToSelector:@selector(yy_importWalletWithImportInfo:)]) {
        [self.delegate yy_importWalletWithImportInfo:self.info];
    }
}

- (YYImportInfo *)info {
    if (!_info) {
        _info = [YYImportInfo new];
    }
    return _info;
}

@end
