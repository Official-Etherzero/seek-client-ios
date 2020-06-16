//
//  WDTokenDetailsController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDTokenDetailsController.h"
#import "YYViewHeader.h"
#import "DetailHeardView.h"
#import "TransferListView.h"
#import "TransferBottomView.h"

#import "TokenDataManager.h"
#import "TokenItem.h"
#import "ClientServer.h"
#import "YYInterfaceMacro.h"
#import "WalletDataManager.h"
#import "YYCacheDataManager.h"

#import "WDCollectionController.h"
#import "WDTransferController.h"
#import "WDTXDetailController.h"

#import "YYInterfaceMacro.h"
#import "YYExchangeRateModel.h"

@interface WDTokenDetailsController ()
<TransferBottomViewDelegate,
TransferListViewDelegate>

@property (nonatomic, strong) TokenItem *item;
@property (nonatomic, strong) DetailHeardView    *headView;
@property (nonatomic, strong) TransferListView   *listView;
@property (nonatomic, strong) TransferBottomView *bottomViw;
//@property (nonatomic,   copy) NSArray <RateModel *>* rateModels;

@end

@implementation WDTokenDetailsController

- (instancetype)initWithTokenItem:(TokenItem *)item {
    if (self = [super init]) {
        self.item = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = self.item.name;
    [self initSubViews];
    WDWeakify(self);
    [[ClientServer sharedInstance] getSeekTxListWithAddress:[WalletDataManager accountModel].address success:^(NSArray<TransferItem *> * items) {
        WDStrongify(self);
        self.listView.items = items;
    } failure:nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getExchangeRates];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initDatas];
}

- (void)initDatas {
    self.listView.items = [YYCacheDataManager getTokenTransferObjectListWithAddress:[WalletDataManager accountModel].address];
}

- (void)getExchangeRates {
    WDWeakify(self);
    [[ClientServer sharedInstance] getRatesComplete:^(NSArray<RateModel *> * _Nonnull rates, float usdt, NSError * _Nonnull error) {
        NSLog(@"rates = %@,usdt = %f,error = %@",rates,usdt,error);
        WDStrongify(self);
        if (rates) {
//            self.rateModels = [YYExchangeRateModel yy_exchangeRateByModels:rates usdtPrice:usdt];
            self.headView.rateModels = [YYExchangeRateModel yy_exchangeRateByModels:rates usdtPrice:usdt];
        }
    }];
}

- (void)initSubViews {
    self.headView = [[DetailHeardView alloc] init];
    [self.view addSubview:self.headView];
    self.headView.item = self.item;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_06);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_06);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_354, YYSIZE_165));
    }];
    
    self.listView = [[TransferListView alloc] init];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.height.mas_offset(YYSIZE_340);
    }];
    
    self.bottomViw = [[TransferBottomView alloc] init];
    self.bottomViw.delegate = self;
    [self.view addSubview:self.bottomViw];;
    [self.bottomViw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_91);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
}

#pragma mark - TransferListViewDelegate

- (void)yy_openTransferDetailControllerWithItem:(TransferItem *)item {
    WDTXDetailController *vc = [[WDTXDetailController alloc] initWithTransferItem:item];
    self.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有 ios8 later
    vc.modalPresentationCapturesStatusBarAppearance = YES;
//    vc.view.backgroundColor = [COLOR_000000_A085 colorWithAlphaComponent:0.5];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - TransferBottomViewDelegate

- (void)yy_openTransferController {
   [self.navigationController pushViewController:[[WDTransferController alloc] initWithTitle:YYStringWithKey(@"转账")] animated:YES];
}

- (void)yy_openCollectionController {
    [self.navigationController pushViewController:[[WDCollectionController new] initWithTitle:YYStringWithKey(@"收款")] animated:YES];
}

@end
