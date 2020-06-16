//
//  WDWalletViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDWalletViewController.h"

#import "WDAddTokenController.h"
#import "WDTokenDetailsController.h"
#import "WDWalletListController.h"
#import "WDScanCodeController.h"
#import "WDCollectionController.h"
#import "WDTransferController.h"
#import "WDMinersController.h"

#import "AccountModel.h"
#import "WalletDataManager.h"
#import "LocalServer.h"
#import "WDWalletUserInfo.h"
#import "YYDateModel.h"
#import "YYUserDefaluts.h"
#import "ClientServer.h"
#import "HSEther.h"
#import "ClientServer.h"
#import "YYExchangeRateModel.h"

#import "WalletHeaderView.h"
#import "YYInterfaceMacro.h"
#import "UIViewController+CWLateralSlide.h"
#import "YYAlertView+Ext.h"
#import "TokenListView.h"
#import "YYViewHeader.h"
#import "APINotifyCenter.h"
#import "YYAddress.h"
#import "UIViewController+Ext.h"
#import "YYToastView.h"

#import "HSEther.h"

@interface WDWalletViewController ()
<WalletHeaderViewDelegate,
TokenListViewDelegate
>

@property (nonatomic, strong) NSMutableArray         *addresses;
@property (nonatomic,   copy) NSString               *praviteString;
@property (nonatomic, strong) WalletHeaderView       *headerView;
@property (nonatomic, strong) TokenListView          *listView;
@property (nonatomic, strong) AccountModel           *account;
@property (nonatomic,   copy) NSArray<RateModel *>   *rateModels;

@end

/** 进入钱包就一直需要去刷新代币的价格*/

@implementation WDWalletViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_ffffff;
    [super viewDidLoad];
    [self initSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyAccountBalanceChange:) name:kAPIAccountModel object:nil];
    
    // 测试节点
//    NSArray *nodes = @[@"http://182.61.139.140:8545",
//                       @"http://104.236.240.227:8545",
//                       @"http://13.251.6.203:8545"];
//    for (NSString *str in nodes) {
//        [HSEther yy_getNodeBlockNumberWithRpcIP:str];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
    [self initialDatas];
}

- (void)initialDatas {
    [self getAccountModel];
    if (self.account) {
        self.headerView.model = self.account;
        [self getMinerLevel];
        [[APINotifyCenter shardInstance] startNotify];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self getExchangeRates];
        });
    } else {
        [self performSelector:@selector(initialDatas) withObject:nil afterDelay:0.1];
    }
}

- (void)initSubViews {
    // HeaderView
    self.headerView = [[WalletHeaderView alloc] init];
    self.headerView.delegate = self;
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_333);
    }];
    
    // 间隔 View
    UIView *intervalView = [UIView new];
    [self.view addSubview:intervalView];
    intervalView.backgroundColor = COLOR_f5f8fa;
    [intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.height.mas_offset(YYSIZE_10);
    }];
    
    // ListView
    self.listView = [[TokenListView alloc] init];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
        make.top.mas_equalTo(intervalView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
    }];
}

- (void)getAccountModel {
    if ([WDWalletUserInfo allObjects].count > 0) {
        NSInteger index = [YYUserDefaluts yy_getAccountModelIndex];
        self.account = [WalletDataManager getAccountsForDataBase][index];
    }
}

- (void)getMinerLevel {
    WDWeakify(self);
    [[ClientServer sharedInstance] getMinerLevelByWalletAddress:self.account.address success:^(long level,id minerInfo) {
        // level 注册矿工后才有等级
        WDStrongify(self);
        self.account.level = [NSString stringWithFormat:@"%ld",level];
        self.headerView.model = self.account;
    } failure:nil];
}

- (void)getExchangeRates {
    WDWeakify(self);
    [[ClientServer sharedInstance] getRatesComplete:^(NSArray<RateModel *> * _Nonnull rates, float usdt, NSError * _Nonnull error) {
        NSLog(@"rates = %@,usdt = %f,error = %@",rates,usdt,error);
        WDStrongify(self);
        if (rates) {
            self.rateModels = [YYExchangeRateModel yy_exchangeRateByModels:rates usdtPrice:usdt];
            NSLog(@"%@",self.rateModels);
            [[NSNotificationCenter defaultCenter] postNotificationName:kExchageRate object:nil userInfo:@{kExchageRateInfo:self.rateModels}];
        }
    }];
}

#pragma mark - WalletHeaderViewDelegate

- (void)yy_openWalletListViewControler {
    // 右侧划出
    WDWalletListController *vc = [[WDWalletListController alloc] init];
    WDWeakify(self)
    vc.walletListCallback = ^(AccountModel * _Nonnull model) {
        WDStrongify(self)
        self.account = model;
        self.headerView.model = model;
        self.listView.model = self.account;
        [WDWalletUserInfo addAccount:self.account];
    };
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight; // 从右边滑出
    conf.finishPercent = 0.2f;
    conf.showAnimDuration = 0.2;
    conf.HiddenAnimDuration = 0.2;
    conf.maskAlpha = 0.1;
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:conf];
}

- (void)yy_functionClickWithCurrentIndex:(NSUInteger)index {
    NSString *title = [WalletDataManager funcTitles][index];
    switch (index) {
        case 0: // 扫一扫
        {
            WDWeakify(self)
            [LocalServer syncAVCaptureDeviceForAuthorizationCompleteHandler:^(NSError * _Nonnull error) {
                WDStrongify(self)
                if (error == nil) {
                    [self.navigationController pushViewController:[[WDScanCodeController alloc] initWithTitle:title] animated:YES];
                }
            }];
        }
            break;
        case 1: // 转账
        {
            WDTransferController *vc = [[WDTransferController alloc] initWithTitle:title];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: // 收款
        {
            [self.navigationController pushViewController:[[WDCollectionController alloc] initWithTitle:title] animated:YES];
        }
            break;
        case 3: // 矿工
        {
            WDWeakify(self);
            [[ClientServer sharedInstance] getMinerInfoByWalletAddress:self.account.address complete:^(NSString *minerInfo) {
                WDStrongify(self);
                if (!minerInfo) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"网络错误") attachedView:self.view];
                } else {
                    [[APINotifyCenter shardInstance] stopNotify];
                    WDMinersController *vc = [[WDMinersController alloc] init];
                    vc.minerInfo = minerInfo;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -notify

- (void)onNotifyAccountBalanceChange:(NSNotification *)notification {
    AccountModel *model = notification.userInfo[kAPIAccountModelInfo];
    dispatch_async_main_safe(^{
        if ([model.address isEqualToString:self.account.address]) {
            // 单一去赋值
            self.account.balance = model.balance;
            self.headerView.model = self.account;
            self.listView.model = self.account;
        }
    });
}

#pragma mark - TokenListViewDelegate

- (void)yy_openAddTokenViewController {
    [self.navigationController pushViewController:[WDAddTokenController new] animated:YES];
}

- (void)yy_openTokenDetailsViewControllerWithItem:(TokenItem *)item {
    WDTokenDetailsController *dvc = [[WDTokenDetailsController alloc] initWithTokenItem:item];
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"asset"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"asset_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"资产");
}

@end
