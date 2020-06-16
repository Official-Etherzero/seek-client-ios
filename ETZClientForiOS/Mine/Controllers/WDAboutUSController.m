//
//  WDAboutUSController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDAboutUSController.h"
#import "YYNavigationView.h"
#import "YYViewHeader.h"
#import "WDPrivacyController.h"

@interface WDAboutUSController ()
<YYNavigationViewDelegate>

@property (nonatomic, strong) YYNavigationView *topView;
@property (nonatomic, strong) UIButton         *pravityButton;
@property (nonatomic, strong) UILabel          *PravityLabel;

@end

@implementation WDAboutUSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
}

- (void)initSubViews {
    self.topView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    self.topView.delegate = self;
    [self.topView returnButton];
    
    self.pravityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.pravityButton];
    [self.pravityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(100, 28));
        make.top.mas_equalTo(self.view.mas_top).offset(320);
    }];
    [self.pravityButton addTarget:self action:@selector(openPravityVCAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.PravityLabel = [[UILabel alloc] init];
    [self.view addSubview:self.PravityLabel];
    [self.PravityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.pravityButton.mas_bottom).offset(10);
    }];
}

- (void)openPravityVCAction:(UIButton *)sender {
    [self.navigationController pushViewController:[WDPrivacyController new] animated:YES];
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
