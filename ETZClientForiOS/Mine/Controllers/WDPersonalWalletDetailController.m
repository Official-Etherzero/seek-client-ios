//
//  WDPersonalWalletDetailController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDPersonalWalletDetailController.h"
#import "YYViewHeader.h"
#import "PersonalCenterCell.h"
#import "PersonalWalletHeaderView.h"
#import "PersonImportPsdView.h"
#import "YYToastView.h"
#import "PersonDeleteWalletView.h"

#import "SettingRowModel.h"
#import "SettingDataSource.h"
#import "YYInterfaceMacro.h"
#import "WalletDataManager.h"
#import "WDWalletUserInfo.h"
#import "YYUserDefaluts.h"

#import "WDChangePasswordController.h"
#import "WDImportPrivateKeyController.h"
#import "WDImportKeystoreController.h"
#import "WDLauncherViewController.h"
#import "WDChangeUserNameController.h"

static NSString *kPersonalWalletCenterCell = @"kPersonalWalletCenterCell";

@interface WDPersonalWalletDetailController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView                *tableView;
@property (nonatomic, strong) UIButton                   *deleteBtn;
@property (nonatomic, strong) AccountModel               *model;
@property (nonatomic,   copy) NSArray                    *items;
@property (nonatomic, strong) SettingDataSource          *walletSource;
@property (nonatomic, strong) PersonalWalletHeaderView   *headerView;
@property (nonatomic, strong) PersonImportPsdView        *psdView;
@property (nonatomic, strong) PersonDeleteWalletView     *deleteView;

@end

@implementation WDPersonalWalletDetailController

- (instancetype)initWithAccountModel:(AccountModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.userName;
    self.view.backgroundColor = COLOR_ffffff;
    [self initSubViews];
    [self initWalletDatas];
}

- (void)initSubViews {
    
    self.headerView = [[PersonalWalletHeaderView alloc] initWithAddress:self.model.address amount:self.model.balance ? self.model.balance : @"0"];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.size.height.mas_offset(YYSIZE_148);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
    }];
    
    UIView *separatorView = [UIView new];
    [self.view addSubview:separatorView];
    separatorView.backgroundColor = COLOR_f5f8fa;
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_10));
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(separatorView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_360);
    }];
    self.tableView.rowHeight = YYSIZE_58;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PersonalCenterCell class]
           forCellReuseIdentifier:kPersonalWalletCenterCell];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.deleteBtn.titleLabel.font = FONT_DESIGN_30;
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn.layer setBorderWidth:1];
    [self.deleteBtn.layer setBorderColor:COLOR_30D1A1.CGColor];
    [self.deleteBtn.layer setMasksToBounds:YES];
    [self.deleteBtn setTitle:YYStringWithKey(@"删除钱包") forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:COLOR_30D1A1 forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:COLOR_ffffff];
    self.deleteBtn.layer.cornerRadius = 5.0f;
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_47));
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_30);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_30);
        }
    }];
    [self.deleteBtn addTarget:self action:@selector(deleteWalletClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initWalletDatas {
    if (!self.walletSource) {
        self.walletSource = [SettingDataSource new];
    }
    self.items = @[[SettingRowModel modelWithTitle:YYStringWithKey(@"钱包备注") desc:self.model.userName  rowType:WDSettingRowTypeDesc],
                   [SettingRowModel modelWithTitle:YYStringWithKey(@"修改密码") rowType:WDSettingRowTypeArrow],
                   [SettingRowModel modelWithTitle:YYStringWithKey(@"导出私钥") rowType:WDSettingRowTypeArrow],
                   [SettingRowModel modelWithTitle:YYStringWithKey(@"导出 Keystore") rowType:WDSettingRowTypeArrow]];
    self.walletSource.sections = @[[SettingHeaderModel modelWithTitle:@"" cells:self.items]].mutableCopy;
    [self.tableView reloadData];
}

- (void)deleteWalletClick {
    self.deleteView = [PersonDeleteWalletView new];
    WDWeakify(self);
    self.deleteView.confirmDeleteBlock = ^{
        WDStrongify(self);
        [YYUserDefaluts yy_updateAccountIndex:self.model];
        [WDWalletUserInfo removeAccount:self.model];
        [self removeDeleteWalletView];
        // 删除当前的钱包，选中的标记位要做一下处理
        if ([WalletDataManager getAccountsForDataBase].count == 0) {
            // 回到创建页面
            NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [vcArray removeAllObjects];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[WDLauncherViewController alloc] init]];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
}

- (void)removeDeleteWalletView {
    [self.deleteView removeFromSuperview];
    self.deleteView = nil;
}

- (void)removePsdView {
    [self.psdView removeFromSuperview];
    self.psdView = nil;
}

- (void)showPsdView {
    self.psdView = [PersonImportPsdView new];
    WDWeakify(self);
    self.psdView.cancelClickBlock = ^{
        WDStrongify(self);
        [self removePsdView];
    };
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.walletSource numberOfRowsInSection:section];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPersonalWalletCenterCell forIndexPath:indexPath];
    cell.model = [self.walletSource rowWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingRowModel *model = [self.walletSource rowWithIndexPath:indexPath];
    // index == 0 修改备注名
    if (indexPath.row == 0) {
        WDChangeUserNameController *uVC = [[WDChangeUserNameController alloc] initWithAccount:self.model];
        WDWeakify(self);
        [uVC setExitCallback:^(AccountModel * _Nonnull model) {
            WDStrongify(self);
            self.navigationItem.title = model.userName;
            self.model = model;
            [self.walletSource.sections removeAllObjects];
            [self initWalletDatas];
        }];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:uVC];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[[WDChangePasswordController alloc] initWithAccountModel:self.model topTitle:model.title] animated:YES];
    } else if (indexPath.row == 2) {
        [self showPsdView];
        WDWeakify(self);
        self.psdView.confirmClickBlock = ^(NSString * _Nonnull content) {
            WDStrongify(self);
            if (content && [self.model.password isEqualToString:content]) {
                [self removePsdView];
                [self.navigationController pushViewController:[[WDImportPrivateKeyController alloc] initWithAccountModel:self.model topTitle:model.title] animated:YES];
            } else if (content.length == 0) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:[UIApplication sharedApplication].keyWindow];
            } else {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"密码错误") attachedView:[UIApplication sharedApplication].keyWindow];
            }
        };
    } else if (indexPath.row == 3) {
        [self showPsdView];
        WDWeakify(self);
        self.psdView.confirmClickBlock = ^(NSString * _Nonnull content) {
            WDStrongify(self);
            if (content && [self.model.password isEqualToString:content]) {
                [self removePsdView];
                [self.navigationController pushViewController:[[WDImportKeystoreController alloc] initWithAccountModel:self.model topTitle:model.title] animated:YES];
            } else if (content.length == 0) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入密码") attachedView:[UIApplication sharedApplication].keyWindow];
            } else {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"密码错误") attachedView:[UIApplication sharedApplication].keyWindow];
            }
        };
    }
}

@end
