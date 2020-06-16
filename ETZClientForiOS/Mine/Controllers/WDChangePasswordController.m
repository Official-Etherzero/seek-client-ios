//
//  WDChangePasswordController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDChangePasswordController.h"

#import "YYViewHeader.h"
#import "YYPlaceholderView.h"
#import "YYToastView.h"
#import "YYPasswordView.h"
#import "YYLoadingView.h"

#import "ClientEtherAPI.h"
#import "YYInterfaceMacro.h"
#import "WDWalletUserInfo.h"

@interface WDChangePasswordController ()

@property (nonatomic, strong) AccountModel       *model;
@property (nonatomic,   copy) NSString           *topTitle;
@property (nonatomic, strong) UIButton           *confirmBtn;
@property (nonatomic, strong) YYPasswordView     *oPsdView;
@property (nonatomic, strong) YYPasswordView     *nPsdView;
@property (nonatomic, strong) YYPasswordView     *rPsdView;
@property (nonatomic, strong) YYLoadingView      *loadingView;

@end

@implementation WDChangePasswordController

- (instancetype)initWithAccountModel:(AccountModel *)model topTitle:(nonnull NSString *)topTitile {
    if (self = [super init]) {
        self.model = model;
        self.topTitle = topTitile;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = self.topTitle;
    [self initSubViews];
    UITapGestureRecognizer *focusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(showKeyboard)];
    [self.view addGestureRecognizer:focusTapGesture];
}

- (void)initSubViews {
    self.oPsdView = [[YYPasswordView alloc] initWithAttackView:self.view title:YYStringWithKey(@"旧密码") plcStr:YYStringWithKey(@"请输入旧密码")];
    [self.oPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.nPsdView = [[YYPasswordView alloc] initWithAttackView:self.view title:YYStringWithKey(@"新密码") plcStr:YYStringWithKey(@"请输入新密码")];
    [self.nPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oPsdView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.rPsdView = [[YYPasswordView alloc] initWithAttackView:self.view title:YYStringWithKey(@"重复密码") plcStr:YYStringWithKey(@"请重复输入密码")];
    [self.rPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nPsdView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn.titleLabel setFont:FONT_DESIGN_30];
    [self.confirmBtn setBackgroundColor:COLOR_30D1A1];
    [self.confirmBtn setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.confirmBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.confirmBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.confirmBtn.layer setMasksToBounds:YES];
    self.confirmBtn.layer.cornerRadius = 5.0f;
    [self.confirmBtn setTitle:YYStringWithKey(@"确认修改") forState:UIControlStateNormal];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rPsdView.mas_bottom).offset(YYSIZE_25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_47));
    }];
    [self.confirmBtn addTarget:self action:@selector(confirmChangeClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showKeyboard {
    [self.oPsdView resignFirstResponder];
    [self.nPsdView resignFirstResponder];
    [self.rPsdView resignFirstResponder];
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

- (void)confirmChangeClick {
    [self showKeyboard];
    if (!(self.oPsdView.content
        && self.nPsdView.content
        && self.rPsdView.content)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:self.view];
        return;
    }
    if (self.oPsdView.content &&
        [self.nPsdView.content isEqualToString:self.oPsdView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码相同") attachedView:self.view];
        return;
    }
    if ((self.oPsdView.content
        && self.nPsdView
        &&  ![self.nPsdView.content isEqualToString:self.rPsdView.content])
        || ![self.oPsdView.content isEqualToString:self.model.password]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码错误") attachedView:self.view];
        return;
    }
    [self showLoadingView];
    [ClientEtherAPI yy_changePasswordWithPrivateKey:self.model.privateKey oldPsw:self.oPsdView.content newPsd:self.nPsdView.content success:^(NSString * _Nonnull key, NSString * _Nonnull keystore) {
        // 修改成功
        WDWeakify(self);
        dispatch_async_main_safe(^{
            WDStrongify(self);
            [self hideLoadingView];
            // 更新数据库
            self.model.password = self.rPsdView.content;
            self.model.privateKey = key;
            self.model.keyStore = keystore;
            [WDWalletUserInfo updateAccount:self.model];
            [YYToastView showCenterWithTitle:YYStringWithKey(@"修改成功") attachedView:self.view show:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        });
    } failure:^(NSError * _Nonnull error) {
        // 修改失败
        dispatch_async_main_safe(^{
            [self hideLoadingView];
            [YYToastView showCenterWithTitle:YYStringWithKey(@"修改失败") attachedView:self.view];
        });
    }];
}

@end
