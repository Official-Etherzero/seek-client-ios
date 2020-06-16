//
//  WDWalletListController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDWalletListController.h"
#import "YYViewHeader.h"
#import "WalletCell.h"
#import "YYInterfaceMacro.h"
#import "UIButton+Ext.h"
#import "WDCreateWalletController.h"
#import "WDImportWalletController.h"
#import "UIViewController+CWLateralSlide.h"
#import "WDWalletViewController.h"
#import "WDWalletUserInfo.h"
#import "AccountModel.h"
#import "WalletDataManager.h"
#import "YYUserDefaluts.h"


static NSString *kWalletIdentifier = @"kWalletIdentifier";

@interface WDWalletListController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIButton        *createBtn;
@property (nonatomic, strong) UIButton        *importBtn;
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *items;
@property (nonatomic, strong) NSIndexPath     *selectedIndexPath;

@end

@implementation WDWalletListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    self.items = [NSMutableArray arrayWithArray:[WalletDataManager getAccountsForDataBase]];
    [self.tableView reloadData];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:[YYUserDefaluts yy_getAccountModelIndex] inSection:0];
//    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)initSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_ffffff;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[WalletCell class] forCellReuseIdentifier:kWalletIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_20);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_20);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_390);
    }];
    if (@available(iOS 11.0, *)) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_ebecf0;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(YYSIZE_20);
        make.left.right.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 1));
    }];
    
    self.createBtn = [self createCustomButton];
    [self.createBtn setImage:[UIImage imageNamed:@"create"] forState:UIControlStateNormal];
    [self.createBtn setTitle:YYStringWithKey(@"创建钱包") forState:UIControlStateNormal];
    [self.createBtn setTitleColor:COLOR_1a1a1a forState:UIControlStateNormal];
    [self.createBtn.titleLabel setFont:FONT_DESIGN_28];
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_23);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_37);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_37);
        }
    }];
    [self.createBtn addTarget:self action:@selector(createWallet) forControlEvents:UIControlEventTouchUpInside];
    
    self.importBtn = [self createCustomButton];
    [self.importBtn setImage:[UIImage imageNamed:@"import"] forState:UIControlStateNormal];
    [self.importBtn setTitle:YYStringWithKey(@"导入钱包") forState:UIControlStateNormal];
    [self.importBtn setTitleColor:COLOR_1a1a1a forState:UIControlStateNormal];
    [self.importBtn.titleLabel setFont:FONT_DESIGN_28];
    [self.importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_23);
        make.bottom.mas_equalTo(self.createBtn.mas_top).offset(-YYSIZE_26);
    }];
    [self.importBtn addTarget:self action:@selector(importWallet) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createWallet {
    [self cw_pushViewController:[WDCreateWalletController new]];
}

- (void)importWallet {
    [self cw_pushViewController:[WDImportWalletController new]];
}

- (UIButton *)createCustomButton {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b yy_leftButtonAndImageWithSpacing:18];
    [self.view addSubview:b];
    return b;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletCell * cell = [self.tableView dequeueReusableCellWithIdentifier:kWalletIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AccountModel *model = self.items[indexPath.row];
    if (self.selectedIndexPath == indexPath) {
        cell.isSelected = YES;
    } else {
        cell.isSelected = NO;
    }
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [YYUserDefaluts yy_setAccountModelIndex:self.selectedIndexPath.row];
    // 这里应该有一个 block 回传数据
    if (self.walletListCallback) {
        self.walletListCallback(self.items[indexPath.row]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
