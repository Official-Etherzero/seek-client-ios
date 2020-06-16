//
//  WDLauncherViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDLauncherViewController.h"
#import "WDTabbarController.h"
#import "WDWalletViewController.h"
#import "YYViewHeader.h"
#import "WDAboutUSController.h"
#import "WDCreateWalletController.h"
#import "WDImportWalletController.h"
#import "YYInterfaceMacro.h"
#import "YYLanguageTool.h"
#import "UIButton+Ext.h"
#import "WDWalletUserInfo.h"
#import "AccountModel.h"

@interface WDLauncherViewController ()

@property (nonatomic, strong) UIImageView        *imageView;
@property (nonatomic, strong) UIButton           *createButton;
@property (nonatomic, strong) UIButton           *importButton;
@property (nonatomic, strong) UIButton           *aboutButton;

@end

@implementation WDLauncherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
#pragma TODO
//这里需要判断下，是否已经创建钱包了，创建了直接进入显示页面，不然就显示创建 UI
    WDWalletUserInfo *info = [WDWalletUserInfo allObjects].lastObject;
    AccountModel *model = [[AccountModel alloc] initWithWalletUserInfo:info];
    if (model.address) {
        [self openTabbarController];
    } else {
        [self initSubViews];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initSubViews {
    
    UIImageView *bgImageView = [UIImageView new];
    [self.view addSubview:bgImageView];
    bgImageView.frame = self.view.bounds;
    bgImageView.image = [UIImage imageNamed:@"login_bg"];
    
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"logo"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(YYSIZE_150);
        make.size.mas_offset(CGSizeMake(YYSIZE_95, YYSIZE_113));
    }];
    
    self.createButton = [self createCustomButton];
    [self.createButton setTitle:YYStringWithKey(@"创建钱包") forState:UIControlStateNormal];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(YYSIZE_200);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.createButton addTarget:self action:@selector(createWallet) forControlEvents:UIControlEventTouchUpInside];
    
    self.importButton = [self createCustomButton];
    [self.importButton setTitle:YYStringWithKey(@"导入钱包") forState:UIControlStateNormal];
    [self.importButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.createButton.mas_bottom).mas_offset(YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.importButton addTarget:self action:@selector(importWallet) forControlEvents:UIControlEventTouchUpInside];
    
    self.aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.aboutButton setTitle:YYStringWithKey(@"关于我们") forState:UIControlStateNormal];
    [self.aboutButton yy_leftButtonAndImageWithSpacing:1];
    [self.aboutButton setImage:[UIImage imageNamed:@"about"] forState:UIControlStateNormal];
    [self.aboutButton.titleLabel setFont:FONT_DESIGN_24];
    [self.aboutButton.titleLabel setTextColor:COLOR_ffffff];
    [self.view addSubview:self.aboutButton];
    [self.aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.createButton.mas_bottom).mas_offset(YYSIZE_108);
        make.size.mas_offset(CGSizeMake(YYSIZE_200, YYSIZE_40));
    }];
    self.aboutButton.enabled = NO;
    [self.aboutButton addTarget:self action:@selector(aboutUS) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UIButton *)createCustomButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:FONT_DESIGN_30];
    [btn setBackgroundColor:COLOR_ffffff];
    [btn setTitleColor:COLOR_30d1a1 forState:UIControlStateNormal];
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btn.layer setMasksToBounds:YES];
    btn.layer.cornerRadius = 25.0f;
    [self.view addSubview:btn];
    return btn;
}

- (void)createWallet {
    [self.navigationController pushViewController:[WDCreateWalletController new] animated:YES];
}

- (void)importWallet {
    [self.navigationController pushViewController:[WDImportWalletController new] animated:YES];
}

- (void)aboutUS {
    [self.navigationController pushViewController:[[WDAboutUSController alloc] initWithTitle:YYStringWithKey(@"关于我们")]  animated:YES];
}

#pragma mark - private

- (void)openTabbarController {
    [UIView transitionWithView:[[UIApplication sharedApplication].delegate window]
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        [UIApplication sharedApplication].delegate.window.rootViewController
                        = [WDTabbarController setupViewControllersWithIndex:0];
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:NULL];
}


@end
