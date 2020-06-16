//
//  WDSendViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/8.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDSendViewController.h"
#import "TransferConfirmView.h"
#import "YYViewHeader.h"
#import "HSEther.h"
#import "AccountModel.h"
#import "WalletDataManager.h"
#import "YYInterfaceMacro.h"
#import "ClientEtherAPI.h"
#import "YYLoadingView.h"
#import "YYToastView.h"
#import "JSModel.h"
#import "YYCalculateModel.h"
#import "ClientServer.h"
#import "APINotifyCenter.h"

@interface WDSendViewController ()
<TransferConfirmViewDelegate>

@property (nonatomic,   copy) NSString              *toAddress;
@property (nonatomic,   copy) NSString              *fromAddress;
@property (nonatomic,   copy) NSString              *minersCost;
@property (nonatomic,   copy) NSString              *gasPrice;
@property (nonatomic,   copy) NSString              *gasLimit;
@property (nonatomic,   copy) NSString              *transferAmout;
@property (nonatomic, strong) TransferConfirmView   *confirmView;
@property (nonatomic, strong) YYLoadingView         *loadingView;
@property (nonatomic, strong) JSModel               *jsModel;
@property (nonatomic, strong) NSError               *error;
@property (nonatomic, strong) UIButton              *confirmButton;
@property (nonatomic, strong) YYPlaceholderView     *minersCostiewView;
@property (nonatomic, strong) AccountModel            *model;

@end

@implementation WDSendViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithTransferToAddress:(NSString *)toAddress
                                 gasPrice:(NSString *)gasPrice
                                 gasLimit:(NSString *)gasLimit
                           transferAmount:(NSString *)transferAmount
                                     cost:(NSString *)cost {
    if (self = [super init]) {
        self.toAddress = toAddress;
        self.fromAddress = [WalletDataManager accountModel].address;
        self.gasPrice = gasPrice;
        self.gasLimit = gasLimit;
        self.transferAmout = transferAmount;
        self.minersCost = cost;
    }
    return self;
}

- (instancetype)initWithJsModel:(JSModel *)model {
    if (self = [super init]) {
        self.jsModel = model;
        self.toAddress = model.contractAddress;
        self.fromAddress = [WalletDataManager accountModel].address;
        self.transferAmout = [YYCalculateModel yy_calculateDividedWithNumString:model.etzValue];
        [self getTransactionCost];
        [[APINotifyCenter shardInstance] startNotify];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    self.model = [WalletDataManager accountModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyAccountBalanceChange:) name:kAPIAccountModel object:nil];
}

- (void)initSubViews {
//    self.view.backgroundColor = COLOR_000000_A085;
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = COLOR_ffffff;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        if (IS_IPHONE_X_orMore) {
            // 如果是 iPhone x 系列就高出 34 像素吧
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_396+34));
        } else {
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_396));
        }
    }];
    
    YYPlaceholderView *transferDetail = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"") content:YYStringWithKey(@"")];
    [bottomView addSubview:transferDetail];
    [transferDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    UILabel *label = [UILabel new];
    [bottomView addSubview:label];
    label.textColor = COLOR_1a1a1a;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = FONT_DESIGN_28;
    label.text = YYStringWithKey(@"转账详情");
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(transferDetail.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    YYButton *closeButton =  [YYButton buttonWithType:UIButtonTypeCustom];
    [transferDetail addSubview:closeButton];
    closeButton.stretchLength = 5.0f;
    [closeButton setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(transferDetail.mas_left).offset(YYSIZE_19);
        make.centerY.mas_equalTo(transferDetail.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_22, YYSIZE_22));
    }];
    [closeButton addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    YYPlaceholderView *toAddressView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"转入地址") content:YYStringWithKey(self.toAddress)];
    [bottomView addSubview:toAddressView];
    [toAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(transferDetail.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    YYPlaceholderView *formAddressView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"付款账户") content:YYStringWithKey(self.fromAddress)];
    [bottomView addSubview:formAddressView];
    [formAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toAddressView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    // 默认为 0
    self.minersCostiewView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"矿工费") content:YYStringWithKey(self.minersCost)];
    [bottomView addSubview:self.minersCostiewView];
    [self.minersCostiewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(formAddressView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    YYPlaceholderView *transferAmountView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"转账金额") content:self.transferAmout];
    [bottomView addSubview:transferAmountView];
    [transferAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.minersCostiewView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_54));
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:confirmButton];
    [confirmButton.titleLabel setFont:FONT_DESIGN_30];
    [confirmButton setBackgroundColor:COLOR_30D1A1];
    [confirmButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [confirmButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [confirmButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    confirmButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [confirmButton.layer setMasksToBounds:YES];
    confirmButton.layer.cornerRadius = 5.0f;
    [confirmButton setTitle:YYStringWithKey(@"确认转账") forState:UIControlStateNormal];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(transferAmountView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_47));
    }];
    [confirmButton addTarget:self action:@selector(confirmTransferClick:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton = confirmButton;
    if (!self.gasLimit) {
       self.confirmButton.enabled = NO;
    }
}

- (void)getTransactionCost {
     WDWeakify(self);
    [ClientEtherAPI yy_getTransactionCostWithFromAddress:self.fromAddress toAddress:self.toAddress dataString:self.jsModel.datas money:self.transferAmout success:^(NSString * _Nonnull gasPrice, NSString * _Nonnull gasLimit, NSString * _Nonnull cost) {
        WDStrongify(self);
        self.confirmButton.enabled = YES;
        self.minersCost = cost;
        self.gasPrice = [gasPrice integerValue] > 0 ? gasPrice : @"0";
        self.gasLimit = gasLimit;
        if (self.minersCostiewView) {
            self.minersCostiewView.desString = cost;
        }
        NSLog(@"gasPrice = %@,gasLimit = %@,cost = %@",gasPrice,gasLimit,cost);
    } failure:^(NSError * _Nonnull error) {
        WDStrongify(self);
        // 没有值的话就用默认的了
        NSLog(@"打印获取 cost 的错误 %@",error);
        if (self.view) {
           [YYToastView showCenterWithTitle:YYStringWithKey(@"gasLimit 评估出错") attachedView:self.view];
        }
        // 如果评估失败就给默认数据
    }];
}

- (void)closeClick:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmTransferClick:(UIButton *)btn {
    if (!self.confirmView) {
        self.confirmView =  [[TransferConfirmView alloc] init];
        self.confirmView.delegate = self;
        [self.view addSubview:self.confirmView];
        // 设置的条件， self.jsModel 存在， self.gasLimit 还未赋值
        if (!self.gasLimit && self.jsModel) {
            [self.confirmView setConfirButtonEnable:NO];
        }
        [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            if (iOS11) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            }
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_396));
        }];
    }
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

#pragma mark - TransferConfirmViewDelegate

- (void)yy_confirmPayClickAction {
    //  这里加一个判断，判断余额够不够
    //  转出金额 + 矿工费用，小于 余额
    if (![YYCalculateModel yy_isCanTradeByBalance:self.model.balance amount:self.transferAmout cost:self.minersCost]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"余额不足") attachedView:self.view];
        return;
    }
    if (!self.confirmView.inputPawView.content) {
        [YYToastView showBelowWithTitle:YYStringWithKey(@"请输入密码") attachedView:self.view];
        return;
    }
    if (self.confirmView.inputPawView.content &&
        ![self.confirmView.inputPawView.content isEqualToString:self.model.password]) {
        [YYToastView showBelowWithTitle:YYStringWithKey(@"密码错误") attachedView:self.view];
        return;
    }
    
    if (self.error) {
        [YYToastView showCenterWithTitle:self.error.userInfo[@"response"] attachedView:self.view];
        return;
    }
    [self showLoadingView];
    WDWeakify(self);
    [ClientEtherAPI yy_sendToAssress:self.toAddress money:self.transferAmout currentKeyStore:self.model.keyStore pwd:self.model.password gasPrice:self.gasPrice gasLimit:self.gasLimit dataStr:self.jsModel.datas block:^(NSString * _Nonnull hashStr, BOOL suc, NSError * _Nonnull error) {
        WDStrongify(self);
        [self hideLoadingView];
        if (hashStr && hashStr.length > 0) {
            if (self.hashCallback) {
                self.hashCallback(hashStr);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kTransferHash object:@{kTransferHashInfo:hashStr}];
            [YYToastView showBelowWithTitle:YYStringWithKey(@"转账成功") attachedView:self.view hide:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            [YYToastView showBelowWithTitle:YYStringWithKey(@"转账失败") attachedView:self.view hide:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }];
}

- (void)yy_returnPayDetailView {
    if (self.confirmView) {
        [self.confirmView removeFromSuperview];
        self.confirmView = nil;
    }
}

#pragma mark -notify

- (void)onNotifyAccountBalanceChange:(NSNotification *)notification {
    AccountModel *model = notification.userInfo[kAPIAccountModelInfo];
    dispatch_async_main_safe(^{
        if ([model.address isEqualToString:self.model.address]) {
            // 单一去赋值
            self.model.balance = model.balance;
        }
    });
}


@end
