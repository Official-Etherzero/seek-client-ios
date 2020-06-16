//
//  WDNodeSwitchController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDNodeSwitchController.h"
#import <BlocksKit/BlocksKit.h>
#import "YYViewHeader.h"
#import "PersonalCenterCell.h"

#import "SettingDataSource.h"
#import "SettingRowModel.h"
#import "SettingHeaderModel.h"
#import "YYSettingNode.h"

static NSString *kNodeSwitchIdentifier = @"kNodeSwitchIdentifier";

@interface WDNodeSwitchController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView            *myTableView;
@property (nonatomic, strong) SettingDataSource      *settingDataSource;
@property (nonatomic, assign) YYSettingNodeType      nodeType;

@end

@implementation WDNodeSwitchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self initDatas];
}


- (void)initDatas {
    self.nodeType = [YYSettingNode currentNodeType];
    self.settingDataSource = [SettingDataSource new];
    self.settingDataSource.sections = @[[SettingHeaderModel modelWithCells:@[[SettingRowModel modelWithTitle:YYSettingNodeTypeDes(YYSettingNodeTyoeGuangzhou)
                                                                                                       value:@(YYSettingNodeTyoeGuangzhou)
                                                                                                     rowType:WDSettingRowTypeCheckbox],
                                                                             [SettingRowModel modelWithTitle:YYSettingNodeTypeDes(YYSettingNodeTypeAmerican)
                                                                                                       value:@(YYSettingNodeTypeAmerican)
                                                                                                     rowType:WDSettingRowTypeCheckbox],
                                                                             [SettingRowModel modelWithTitle:YYSettingNodeTypeDes(YYSettingNodeTypeKorea)
                                                                                                       value:@(YYSettingNodeTypeKorea)
                                                                                                     rowType:WDSettingRowTypeCheckbox],
                                                                             [SettingRowModel modelWithTitle:YYSettingNodeTypeDes(YYSettingNodeTypeSingapore)
                                                                                                       value:@(YYSettingNodeTypeSingapore)
                                                                                                     rowType:WDSettingRowTypeCheckbox]]]].mutableCopy;
    
    [self.settingDataSource.sections bk_each:^(SettingHeaderModel * _Nonnull section) {
        [section.rows bk_each:^(SettingRowModel * _Nonnull row) {
            row.selected = [row.value isEqualToValue:@(self.nodeType)];
        }];
    }];
    [self.myTableView reloadData];
}

- (void)initSubViews {
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.backgroundColor = COLOR_ffffff;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.scrollEnabled = NO;
    [self.myTableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:kNodeSwitchIdentifier];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingDataSource numberOfRowsInSection:section];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YYSIZE_60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell * cell = [self.myTableView dequeueReusableCellWithIdentifier:kNodeSwitchIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.settingDataSource rowWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.settingDataSource selectedAllRow:NO];
    SettingRowModel *rowModel = [self.settingDataSource rowWithIndexPath:indexPath];
    YYSettingNodeType type;
    [rowModel.value getValue:&type];
    self.nodeType = type;
    rowModel.selected = YES;
    [YYSettingNode yy_setNodeType:type];
    [self.myTableView reloadData];
}


@end
