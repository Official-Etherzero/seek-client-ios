//
//  WDSettingLanguageSelectorController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDSettingLanguageSelectorController.h"
#import <BlocksKit/BlocksKit.h>
#import "YYViewHeader.h"
#import "PersonalCenterCell.h"

#import "SettingDataSource.h"
#import "SettingRowModel.h"
#import "SettingHeaderModel.h"
#import "YYNavigationView.h"


static NSString *kSettingLanguageIdentifier = @"kSettingLanguageIdentifier";

@interface WDSettingLanguageSelectorController ()
<UITableViewDelegate,
UITableViewDataSource,
YYNavigationViewDelegate>

@property (nonatomic, strong) UITableView            *myTableView;
@property (nonatomic, strong) SettingDataSource      *settingDataSource;
@property (nonatomic, assign) YYSettingLanguageType  languageType;
@property (nonatomic, strong) YYNavigationView       *topView;

@end

@implementation WDSettingLanguageSelectorController

- (void)viewDidLoad {
    self.navigationItem.title = YYStringWithKey(@"语言设置");
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self initDatas];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)initDatas {
    self.languageType = [YYLanguageTool shareInstance].currentType;
    self.settingDataSource = [SettingDataSource new];
    self.settingDataSource.sections = @[[SettingHeaderModel modelWithCells:@[[SettingRowModel modelWithTitle:YYSettingLanguageTypeDesc(YYSettingLanguageTypeChineseSimple)
                                                                                                       value:@(YYSettingLanguageTypeChineseSimple)
                                                                                                     rowType:WDSettingRowTypeCheckbox],
                                                                             [SettingRowModel modelWithTitle:YYSettingLanguageTypeDesc(YYSettingLanguageTypeEnglish)
                                                                                                       value:@(YYSettingLanguageTypeEnglish)
                                                                                                     rowType:WDSettingRowTypeCheckbox],
                                                                             [SettingRowModel modelWithTitle:YYSettingLanguageTypeDesc(YYSettingLanguageTypeKorea)
                                                                                                       value:@(YYSettingLanguageTypeKorea)
                                                                                                     rowType:WDSettingRowTypeCheckbox]]]].mutableCopy;
    
    [self.settingDataSource.sections bk_each:^(SettingHeaderModel * _Nonnull section) {
        [section.rows bk_each:^(SettingRowModel * _Nonnull row) {
            row.selected = [row.value isEqualToValue:@(self.languageType)];
        }];
    }];
    [self.myTableView reloadData];
}

- (void)initSubViews {
    self.topView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    self.topView.delegate = self;
    [self.topView returnButton];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.backgroundColor = COLOR_ffffff;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.scrollEnabled = NO;
    [self.myTableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:kSettingLanguageIdentifier];
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

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [[YYLanguageTool shareInstance] setLanguage:self.languageType];
    if ([self.delegate respondsToSelector:@selector(yy_settingLanguageSelectorControllerDidAction)]) {
        [self.delegate yy_settingLanguageSelectorControllerDidAction];
    }
    [self.navigationController popoverPresentationController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingDataSource numberOfRowsInSection:section];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YYSIZE_60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell * cell = [self.myTableView dequeueReusableCellWithIdentifier:kSettingLanguageIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.settingDataSource rowWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.settingDataSource selectedAllRow:NO];
    SettingRowModel *rowModel = [self.settingDataSource rowWithIndexPath:indexPath];
    YYSettingLanguageType type;
    [rowModel.value getValue:&type];
    self.languageType = type;
    rowModel.selected = YES;
    [self.myTableView reloadData];
}

@end
