//
//  WDMineViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDMineViewController.h"
#import "YYColor.h"
#import "SettingDataSource.h"
#import "PersonalCenterCell.h"
#import "PersonalHeader.h"
#import "SettingRowModel.h"
#import "YYLanguageTool.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"

#import "WDManagerWalletController.h"
#import "WDSettingLanguageSelectorController.h"
#import "WDNodeSwitchController.h"
#import "WDHelpCenterController.h"
#import "WDAboutUSController.h"
#import "UIViewController+Ext.h"

#import "WDTabbarController.h"


#define WALLET_MANAGER [NSIndexPath indexPathForRow:0 inSection:0]
#define LANGUAGE_SET [NSIndexPath indexPathForRow:0 inSection:1]
#define NODE_CHANGE [NSIndexPath indexPathForRow:1 inSection:1]
#define HELP_CENTER [NSIndexPath indexPathForRow:0 inSection:2]
#define ABOUT_US [NSIndexPath indexPathForRow:1 inSection:2]

@interface WDMineViewController ()
<UITableViewDelegate,
UITableViewDataSource,
WDSettingLanguageSelectorControllerDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSArray           *items;
@property (nonatomic, strong) SettingDataSource *settingDataSource;
@property (nonatomic, strong) NSMutableArray    *wallets;
@property (nonatomic, strong) NSMutableArray    *systems;
@property (nonatomic, strong) NSMutableArray    *otheres;


@end

@implementation WDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"个人中心");
    self.view.backgroundColor = COLOR_05b17e;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTableView];
    [self initCellData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
//    [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:2];
}

#pragma mark - property

- (void)setTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.rowHeight = YYSIZE_44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PersonalHeader class]
forHeaderFooterViewReuseIdentifier:PersonalHeader.identifier];
    [self.tableView registerClass:[PersonalCenterCell class]
           forCellReuseIdentifier:PersonalCenterCell.identifier];
}

- (void)initCellData {
    self.settingDataSource = [SettingDataSource new];
    self.wallets = [NSMutableArray array];
    self.systems = [NSMutableArray array];
    self.otheres = [NSMutableArray array];
    [self.wallets addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"wallet_manager" title:YYStringWithKey(@"钱包管理") rowType:WDSettingRowTypeArrow]]];
    [self.systems addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"language_set"         title:YYStringWithKey(@"语言设置") rowType:WDSettingRowTypeArrow],
                                        [SettingRowModel modelWithImageName:@"node_change" title:YYStringWithKey(@"节点切换") rowType:WDSettingRowTypeArrow]]];
    [self.otheres addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"help_center" title:YYStringWithKey(@"帮助中心") rowType:WDSettingRowTypeArrow],
                                        [SettingRowModel modelWithImageName:@"about_us" title:YYStringWithKey(@"关于我们") rowType:WDSettingRowTypeArrow]]];
    
    self.settingDataSource.sections = @[[SettingHeaderModel modelWithTitle:YYStringWithKey(@"钱包") cells:self.wallets],
                                         [SettingHeaderModel modelWithTitle:YYStringWithKey(@"系统设置") cells:self.systems],
                                         [SettingHeaderModel modelWithTitle:YYStringWithKey(@"其它") cells:self.otheres]].mutableCopy;
    [self.tableView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingDataSource.numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingDataSource numberOfRowsInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PersonalHeader *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:PersonalHeader.identifier];
    header.model = [self.settingDataSource sectionModelWithSection:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PersonalCenterCell.identifier
                                                                   forIndexPath:indexPath];
    cell.model = [self.settingDataSource rowWithIndexPath:indexPath];
    return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return PersonalHeader.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YYSIZE_60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingRowModel *model = [self.settingDataSource rowWithIndexPath:indexPath];
    if (NSIndexPathEqual(indexPath, WALLET_MANAGER)) {
        [self.navigationController pushViewController:[[WDManagerWalletController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
    } else if (NSIndexPathEqual(indexPath, LANGUAGE_SET)) {
        WDSettingLanguageSelectorController *vc = [WDSettingLanguageSelectorController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
//        [self.navigationController pushViewController:[[WDSettingLanguageSelectorController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
    } else if (NSIndexPathEqual(indexPath, NODE_CHANGE)) {
        [self.navigationController pushViewController:[[WDNodeSwitchController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
    } else if (NSIndexPathEqual(indexPath, HELP_CENTER)) {
        // 这里暂时不让点击
        return;
        [self.navigationController pushViewController:[[WDHelpCenterController alloc]initWithTitle:YYStringWithKey(model.title)] animated:YES];
    } else if (NSIndexPathEqual(indexPath, ABOUT_US)) {
        // 这里暂时不让点击
        return;
        [self.navigationController pushViewController:[[WDAboutUSController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
    }
    [self yy_hideTabBar:YES];
}

#pragma mark - WDSettingLanguageSelectorControllerDelegate

- (void)yy_settingLanguageSelectorControllerDidAction {
    [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:2];
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"user"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"user_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"我");
}

@end
