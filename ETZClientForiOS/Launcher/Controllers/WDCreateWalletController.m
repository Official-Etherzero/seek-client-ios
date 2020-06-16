//
//  WDCreateWalletController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDCreateWalletController.h"
#import "YYInterfaceMacro.h"
#import "YYLanguageTool.h"
#import "YYViewHeader.h"
#import "HSEther.h"
#import "WDPrivacyController.h"
#import "YYPlaceholderView.h"
#import "NSString+Ext.h"
#import "YYLoadingView.h"
#import "WDMnemonicController.h"
#import "AccountModel.h"
#import "WDWalletUserInfo.h"
#import "YYToastView.h"
#import "ClientEtherAPI.h"
#import "YYPasswordView.h"

@interface WDCreateWalletController ()
<UITextViewDelegate>

@property (nonatomic, strong) YYPlaceholderView  *noteView;
@property (nonatomic, strong) YYPasswordView     *inputPasswordView;
@property (nonatomic, strong) YYPasswordView     *confirmPasswordView;

@property (nonatomic, strong) YYLoadingView      *loadingView;

@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UIButton *privacyButton;

@property (nonatomic, strong) UILabel  *instructionLabel;
@property (nonatomic, strong) UILabel  *createLabel;

@end

@implementation WDCreateWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"创建钱包");
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    UITapGestureRecognizer *focusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(showKeyboard)];
    [self.view addGestureRecognizer:focusTapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initSubViews {
    
    self.noteView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"钱包备注") plcStr:YYStringWithKey(@"请输入钱包备注")];
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.inputPasswordView = [[YYPasswordView alloc] initWithAttackView:self.view title:YYStringWithKey(@"钱包密码") plcStr:YYStringWithKey(@"请输入钱包密码")];
    [self.inputPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noteView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.confirmPasswordView = [[YYPasswordView alloc] initWithAttackView:self.view title:YYStringWithKey(@"确认密码") plcStr:YYStringWithKey(@"请确认钱包密码")];
    [self.confirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputPasswordView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.checkButton];
    [self.checkButton setImage:[UIImage imageNamed:@"Check"] forState:UIControlStateSelected];
    [self.checkButton setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.confirmPasswordView.mas_bottom).offset(YYSIZE_44);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_76);
    }];
    [self.checkButton addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    self.checkButton.selected = YES;
    
    self.instructionLabel = [UILabel new];
    [self.view addSubview:self.instructionLabel];
    self.instructionLabel.text = YYStringWithKey(@"我已经仔细阅读并同意");
    [self.instructionLabel setFont:FONT_DESIGN_24];
    self.instructionLabel.textAlignment = NSTextAlignmentLeft;
    self.instructionLabel.textColor = COLOR_30D1A1;
    [self.instructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkButton.mas_right).offset(YYSIZE_07);
        make.centerY.mas_equalTo(self.checkButton.mas_centerY);
    }];
    
    self.privacyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.privacyButton];
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:YYStringWithKey(@"服务及隐私条款") attributes:attribtDic];
    self.privacyButton.titleLabel.attributedText = attribtStr;
    [self.privacyButton setTitle:YYStringWithKey(@"服务及隐私条款") forState:UIControlStateNormal];
    [self.privacyButton.titleLabel setFont:FONT_DESIGN_24];
    [self.privacyButton setTitleColor:COLOR_30D1A1 forState:UIControlStateNormal];
    [self.privacyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.instructionLabel.mas_right);
        make.centerY.mas_equalTo(self.instructionLabel.mas_centerY);
        make.height.mas_offset(YYSIZE_40);
    }];
    [self.privacyButton addTarget:self action:@selector(privacyClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.createButton];
    [self.createButton.titleLabel setFont:FONT_DESIGN_30];
    [self.createButton setBackgroundColor:COLOR_30D1A1];
    [self.createButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.createButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.createButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.createButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.createButton.layer setMasksToBounds:YES];
    self.createButton.layer.cornerRadius = 5.0f;
    [self.createButton setTitle:YYStringWithKey(@"创建钱包") forState:UIControlStateNormal];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-YYSIZE_293);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.createButton addTarget:self action:@selector(createWalletClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - method

- (void)checkClick:(UIButton *)btn {
    self.checkButton.selected = !btn.selected;
    // 勾选
}

- (void)privacyClickAction {
    // 进入隐私页面
    [self.navigationController pushViewController:[WDPrivacyController new] animated:YES];
}

- (void)createWalletClick:(UIButton *)btn {
    // 判断。备注是要的，密码是不是一致
    if (!self.noteView.content
        || self.noteView.content.length == 0) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入备注") attachedView:self.view];
        return;
    }
    if (!self.inputPasswordView.content) {
        [YYToastView showCenterWithTitle:@"请输入密码" attachedView:self.view];
        return;
    }
    if (!self.confirmPasswordView.content) {
        [YYToastView showCenterWithTitle:@"请输入密码" attachedView:self.view];
        return;
    }
    if (self.inputPasswordView.content.length < 6 || self.inputPasswordView.content.length > 12) {
        [YYToastView showCenterWithTitle:@"请输入6~12位长度密码" attachedView:self.view];
        return;
    }
    if (![self.confirmPasswordView.content isEqualToString:self.inputPasswordView.content]) {
        // 密码不正确
        [YYToastView showCenterWithTitle:@"密码不正确" attachedView:self.view];
        return;
    }
    [self showLoadingView];
    [self showKeyboard];
    WDWeakify(self);
    [ClientEtherAPI yy_createWalletWithUserName:self.noteView.content password:self.confirmPasswordView.content completeBlock:^(AccountModel * _Nonnull model) {
        WDStrongify(self);
        [self hideLoadingView];
        if (model && model.address.length > 0) {
            WDMnemonicController *vc = [[WDMnemonicController alloc] initWithAccountModel:model];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"创建钱包失败") attachedView:self.view];
        }
    }];
}

- (void)showLoadingView {
    if (!self.loadingView) {
        self.loadingView = [[YYLoadingView alloc] initBottomView:self.view];
    }
}

- (void)hideLoadingView {
    if (self.loadingView) {
        [self.loadingView hide];
        self.loadingView = nil;
    }
}

- (void)showKeyboard {
    [self.noteView resignFirstResponder];
    [self.confirmPasswordView resignFirstResponder];
    [self.inputPasswordView resignFirstResponder];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

@end
