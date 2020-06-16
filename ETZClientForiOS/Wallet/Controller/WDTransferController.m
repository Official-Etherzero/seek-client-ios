//
//  WDTransferController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDTransferController.h"
#import "WDScanCodeController.h"
#import "WDSendViewController.h"

#import "WalletDataManager.h"
#import "AccountModel.h"
#import "WalletDataManager.h"
#import "ClientEtherAPI.h"

#import "YYPlaceholderView.h"
#import "YYTextView.h"
#import "YYToastView.h"

#import "YYViewHeader.h"
#import "HSEther.h"
#import "YYInterfaceMacro.h"

@interface WDTransferController ()

@property (nonatomic, strong) YYPlaceholderView *collectAddressView;
@property (nonatomic, strong) YYPlaceholderView *transferAmountView;
@property (nonatomic, strong) YYPlaceholderView *gasPriceView;
@property (nonatomic, strong) YYPlaceholderView *gasLimitView;
@property (nonatomic, strong) YYPlaceholderView *noteView;
@property (nonatomic, strong) YYTextView        *inputView;
@property (nonatomic, strong) UIButton          *confirmButton;
@property (nonatomic, strong) YYButton          *scanButton;
@property (nonatomic, strong) UILabel           *gasView;
@property (nonatomic, strong) UILabel           *transferDataView;

@property (nonatomic,   copy) NSString          *scanString;
@property (nonatomic,   copy) NSString          *cost;

@end

@implementation WDTransferController

- (void)dealloc {
    [self.collectAddressView removeObserver:self forKeyPath:@"content"];
}

- (instancetype)initWithScanString:(NSString *)str {
    if (self = [super init]) {
        self.scanString = str;
        [self estimateGas];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    UITapGestureRecognizer *focusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(showKeyboard)];
    [self.view addGestureRecognizer:focusTapGesture];
    [self.collectAddressView addObserver: self forKeyPath: @"content" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
}

- (void)initSubViews {
    self.collectAddressView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"收款地址") plcStr:YYStringWithKey(@"请输入收款地址")];
    [self.collectAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.scanButton = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.scanButton];
    self.scanButton.stretchLength = 5.0f;
    [self.scanButton setImage:[UIImage imageNamed:@"saoma"] forState:UIControlStateNormal];
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.collectAddressView.mas_right).offset(-YYSIZE_24);
        make.centerY.mas_equalTo(self.collectAddressView.mas_centerY);
    }];
    [self.scanButton addTarget:self action:@selector(scanClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.transferAmountView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"转账金额") plcStr:YYStringWithKey(@"请输入转账金额")];
    [self.transferAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectAddressView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    // 请输入
    self.gasPriceView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"Gas Price") plcStr:YYStringWithKey(@"10")];
    [self.gasPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.transferAmountView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    // 请输入
    self.gasLimitView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"Gas Limit") plcStr:YYStringWithKey(@"21000")];
    [self.gasLimitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gasPriceView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.transferDataView = [UILabel new];
    [self.view addSubview:self.transferDataView];
    self.transferDataView.textColor = COLOR_1a1919;
    [self.transferDataView setFont:FONT_DESIGN_28];
    self.transferDataView.text = YYStringWithKey(@"交易数据");
    [self.transferDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_22);
        make.top.mas_equalTo(self.gasLimitView.mas_bottom).offset(YYSIZE_25);
    }];
    
    self.inputView = [[YYTextView alloc] init];
    self.inputView.placeholderColor = COLOR_1a1a1a_A025;
    self.inputView.placeholder = YYStringWithKey(@"请输入");
    self.inputView.layer.borderColor = COLOR_1a1a1a_A025.CGColor;
    self.inputView.layer.borderWidth = 0.5;
    self.inputView.layer.cornerRadius = 5.0;
    self.inputView.textAlignment = NSTextAlignmentLeft;
    [self.inputView setFont:FONT_DESIGN_28];
    self.inputView.textContainerInset = UIEdgeInsetsMake(15, 16, 15,16);
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.transferDataView.mas_right).offset(40);
        make.top.mas_equalTo(self.gasLimitView.mas_bottom).offset(25);
        make.size.mas_offset(CGSizeMake(237, 125));
    }];
    
    self.noteView = [[YYPlaceholderView alloc] initWithAttackView:self.view title:YYStringWithKey(@"备注") plcStr:YYStringWithKey(@"请输入您的转账备注")];
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 65));
    }];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.confirmButton];
    [self.confirmButton.titleLabel setFont:FONT_DESIGN_30];
    [self.confirmButton setBackgroundColor:COLOR_30D1A1];
    [self.confirmButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.confirmButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.confirmButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.confirmButton.layer setMasksToBounds:YES];
    self.confirmButton.layer.cornerRadius = 5.0f;
    [self.confirmButton setTitle:YYStringWithKey(@"下一步") forState:UIControlStateNormal];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noteView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    self.confirmButton.enabled = NO;
    [self.confirmButton addTarget:self action:@selector(nextStepClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.scanString) {
        self.collectAddressView.content = self.scanString;
    }
    
    // gasprice 默认为 10，gaslimit 默认为 21000；
//    self.gasPriceView.content = @"10";
//    self.gasLimitView.content = @"21000";
}

- (void)scanClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[WDScanCodeController alloc] initWithTitle:YYStringWithKey(@"扫一扫")] animated:YES];
}

- (void)nextStepClick:(UIButton *)sender {
    // 收款地址 && 转账金额不允许为空
    if (!self.collectAddressView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入转账地址") attachedView:self.view];
        return;
    }
    if (!self.transferAmountView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入转账金额") attachedView:self.view];
        return;
    }
    if (!ISETHADDRESS(self.collectAddressView.content)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"不是目标地址") attachedView:self.view];
        return;
    }
    if ([self.collectAddressView.content isEqualToString:[WalletDataManager accountModel].address]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"收款地址和转账地址相同") attachedView:self.view];
        return;
    }
//    if (!(self.gasPriceView && self.gasPriceView.content.length > 0)) {
//        [YYToastView showCenterWithTitle:YYStringWithKey(@"gasprice 不能为空") attachedView:self.view];
//        return;
//    }
//    if (!(self.gasLimitView && self.gasLimitView.content.length > 0)) {
//        [YYToastView showCenterWithTitle:YYStringWithKey(@"gaslimit 不能为空") attachedView:self.view];
//        return;
//    }
    WDSendViewController *vc = [[WDSendViewController alloc] initWithTransferToAddress:self.collectAddressView.content gasPrice:self.gasPriceView.content gasLimit:self.gasLimitView.content transferAmount:self.transferAmountView.content cost:self.cost];
    self.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有 ios8 later
    vc.view.backgroundColor = [COLOR_000000_A085 colorWithAlphaComponent:0.5];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)showKeyboard {
    [self.collectAddressView resignFirstResponder];
    [self.transferAmountView resignFirstResponder];
    [self.noteView resignFirstResponder];
    [self.gasLimitView resignFirstResponder];
    [self.gasPriceView resignFirstResponder];
    [self.inputView resignFirstResponder];
}

- (void)estimateGas {
    WDWeakify(self);
    [ClientEtherAPI yy_getTransactionCostWithFromAddress:[WalletDataManager accountModel].address toAddress:self.collectAddressView.content dataString:@"" money:@"0" success:^(NSString * _Nonnull gasPrice, NSString * _Nonnull gasLimit, NSString * _Nonnull cost) {
        WDStrongify(self);
        self.confirmButton.enabled = YES;
        self.gasPriceView.content = [gasPrice integerValue] > 0 ? gasPrice : @"0";
        self.gasLimitView.content = gasLimit;
        NSLog(@"gasPrice = %@,gasLimit = %@,cost = %@",gasPrice,gasLimit,cost);
        self.cost = cost;
    } failure:^(NSError * _Nonnull error) {
        WDStrongify(self);
        // 没有值的话就用默认的了
        NSLog(@"打印获取 cost 的错误 %@",error);
        // 如果评估失败就给默认数据
        self.confirmButton.enabled = YES;
        self.gasPriceView.content = @"10";
        self.gasLimitView.content = @"21000";
        self.cost = @"0.00021";
    }];
}

#pragma mark - obser

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"content"]) {
        if (ISETHADDRESS(self.collectAddressView.content)) {
            // 这里进行一个评估
            [self estimateGas];
        }
    }
}

@end
