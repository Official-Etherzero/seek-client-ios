//
//  WDManagerWalletController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDManagerWalletController.h"

#import "WDImportWalletController.h"
#import "WDCreateWalletController.h"
#import "WDPersonalWalletDetailController.h"

#import "YYViewHeader.h"
#import "PersonWalletCell.h"

#import "WalletDataManager.h"
#import "AccountModel.h"
#import "YYInterfaceMacro.h"

static NSString *kManagerWalletIdentifier = @"kManagerWalletIdentifier";

@interface WDManagerWalletController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView         *myTableView;
@property (nonatomic, strong) NSMutableArray      *wallets;

@end

@implementation WDManagerWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;;
    [self initSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyTokenBalanceChange:) name:kAPIWalletList object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.wallets = [WalletDataManager getAccountsForDataBase].mutableCopy;
    [self.myTableView reloadData];
}

- (void)initSubViews {
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.backgroundColor = COLOR_ffffff;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.myTableView.scrollEnabled = NO;
    [self.myTableView registerClass:[PersonWalletCell class] forCellReuseIdentifier:kManagerWalletIdentifier];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        if ([self.myTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

- (void)onNotifyTokenBalanceChange:(NSNotification *)notification {
    AccountModel *model = notification.userInfo[kAPIWalletListInfo];
    dispatch_async_main_safe(^{
        for (AccountModel *item in self.wallets) {
            if ([model.address isEqualToString:item.address]) {
                item.balance = model.balance;
//                NSInteger index = [self.wallets indexOfObject:item];
//                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
//                PersonWalletCell *cell = (PersonWalletCell *)[self.myTableView cellForRowAtIndexPath:path];
//                cell.balance = model.balance;
            }
        }
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wallets.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonWalletCell * cell = [self.myTableView dequeueReusableCellWithIdentifier:kManagerWalletIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AccountModel *model = self.wallets[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountModel *model = self.wallets[indexPath.row];
    [self.navigationController pushViewController:[[WDPersonalWalletDetailController alloc] initWithAccountModel:model] animated:YES];
}

@end
