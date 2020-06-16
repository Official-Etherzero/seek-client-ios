//
//  WDImportWalletController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDImportWalletController.h"
#import "YYInterfaceMacro.h"
#import "YYLanguageTool.h"
#import "YYPageView.h"
#import "YYViewHeader.h"
#import "YYImportWalletView.h"
#import "HSEther.h"
#import "AccountModel.h"
#import "WDTabbarController.h"
#import "WDWalletUserInfo.h"
#import "YYToastView.h"
#import "YYLoadingView.h"
#import "WalletDataManager.h"

@interface WDImportWalletController ()
<YYPageViewDelegate,
YYImportWalletViewDelegate,
UIScrollViewDelegate>

@property (nonatomic, strong) YYPageView          *pageView;
@property (nonatomic, strong) YYImportWalletView  *importView;
@property (nonatomic, strong) UIScrollView        *scrollView;
@property (nonatomic, strong) YYLoadingView       *loadingView;

@end

@implementation WDImportWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"导入钱包");
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    UITapGestureRecognizer *focusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(showKeyboard)];
    [self.view addGestureRecognizer:focusTapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initSubViews {
    
    NSArray *titles = @[@"助记词",@"私钥",@"Keystore"];
    if (IS_IPHONE_X_orMore) {
        self.pageView = [[YYPageView alloc] initWithFrame:CGRectMake(0, 88, YYSCREEN_WIDTH, YYSIZE_42) titles:titles];
    } else {
        self.pageView = [[YYPageView alloc] initWithFrame:CGRectMake(0, 64, YYSCREEN_WIDTH, YYSIZE_42) titles:titles];
    }
    [self.view addSubview:self.pageView];
    self.pageView.delegate = self;
    self.pageView.index = 0;
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_ebecf0;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageView.mas_bottom).offset(1);
        make.left.right.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 1));
    }];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentSize = CGSizeMake(YYSCREEN_WIDTH *3,0);
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    self.scrollView.canCancelContentTouches = YES;
    self.scrollView.delaysContentTouches = NO;
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_42);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_42);
        }
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    YYImportWalletView *mnemonicView = [[YYImportWalletView alloc] initWithFrame:CGRectMake(0, 0, YYSCREEN_WIDTH, 640) style:YYImportMnemonic desStr:YYStringWithKey(@"请输入助记词，按空格分隔")];
    YYImportWalletView *privateKey = [[YYImportWalletView alloc] initWithFrame:CGRectMake(YYSCREEN_WIDTH, 0, YYSCREEN_WIDTH, 640) style:YYImportPrivateKey desStr:YYStringWithKey(@"请输入私钥")];
    YYImportWalletView *keystore = [[YYImportWalletView alloc] initWithFrame:CGRectMake(YYSCREEN_WIDTH *2, 0, YYSCREEN_WIDTH, 640) style:YYImportKeystore desStr:YYStringWithKey(@"请输入钱包keystore")];
    mnemonicView.delegate = self;
    privateKey.delegate = self;
    keystore.delegate = self;
    [self.scrollView addSubview:mnemonicView];
    [self.scrollView addSubview:privateKey];
    [self.scrollView addSubview:keystore];
}

- (void)showLoadingView {
    if (!self.loadingView) {
        self.loadingView = [[YYLoadingView alloc] initBottomView:self.view];
    }
}

- (void)hideLoadingView {
    if (self.loadingView) {
        [self.loadingView hide];
        self.loadingView = nil;
    }
}

#pragma mark - YYImportWalletViewDelegate

- (void)yy_importWalletWithImportInfo:(YYImportInfo *)info {
    [self showLoadingView];
    // 导入成功后再做一次判断，钱包是否存在
    if (info.style == YYImportMnemonic) {
        // 导入助记词
        WDWeakify(self)
        [HSEther hs_inportMnemonics:info.content pwd:info.psw block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
            WDStrongify(self)
            [self hideLoadingView];
            if (privateKey && privateKey.length > 0) {
                if ([WalletDataManager yy_walletIsExistByWalletAddress:address]) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"钱包已存在") attachedView:self.view];
                } else {
                    [self createAccountModelEnterWalletWithUserName:info.name password:info.psw address:address mnemonic:mnemonicPhrase privateKey:privateKey keyStore:keyStore];
                }
            } else {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"助记词错误") attachedView:self.view];
            }
        }];
    } else if (info.style == YYImportKeystore) {
        // 导入 keystore
        WDWeakify(self)
        [HSEther hs_importKeyStore:info.content pwd:info.psw block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
            WDStrongify(self)
            [self hideLoadingView];
            if (privateKey && privateKey.length > 0) {
                if ([WalletDataManager yy_walletIsExistByWalletAddress:address]) {
                    if (self.view) {
                        [YYToastView showCenterWithTitle:YYStringWithKey(@"钱包已存在") attachedView:self.view];
                    }
                } else {
                    [self createAccountModelEnterWalletWithUserName:info.name password:info.psw address:address mnemonic:mnemonicPhrase privateKey:privateKey keyStore:keyStore];
                }
            } else {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"Keystore错误") attachedView:self.view];
            }
        }];
    } else if (info.style == YYImportPrivateKey) {
        // 导入私钥
        WDWeakify(self)
        [HSEther hs_importWalletForPrivateKey:info.content pwd:info.psw block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
            WDStrongify(self)
            [self hideLoadingView];
            if (privateKey && privateKey.length > 0) {
                if ([WalletDataManager yy_walletIsExistByWalletAddress:address]) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"钱包已存在") attachedView:self.view];
                } else {
                    [self createAccountModelEnterWalletWithUserName:info.name password:info.psw address:address mnemonic:mnemonicPhrase privateKey:privateKey keyStore:keyStore];
                }
            } else {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"私钥错误") attachedView:self.view];
            }
        }];
    }
}

- (void)createAccountModelEnterWalletWithUserName:(NSString *)username
                                         password:(NSString *)password
                                          address:(NSString *)address
                                         mnemonic:(NSString *)mnemonic
                                       privateKey:(NSString *)privateKey
                                         keyStore:(NSString *)keyStore {
    AccountModel *model = [AccountModel new];
    model.address = address;
    model.keyStore = keyStore;
    model.mnemonicPhrase = mnemonic;
    model.privateKey = privateKey;
    model.userName = username;
    model.password = password;
    model.decimal = @"18";
    
    // model 写入数据库
    [WDWalletUserInfo addAccount:model];
    [UIApplication sharedApplication].delegate.window.rootViewController
    = [WDTabbarController setupViewControllersWithIndex:0];
}

- (void)showKeyboard {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KShowKeyboard" object:nil];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"Decelerating : %f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"Dragging : %f",scrollView.contentOffset.x);
    
    if ((int)scrollView.contentOffset.x > (YYSCREEN_WIDTH *self.pageView.index)
        && self.pageView.index < 2) {
        self.pageView.index ++;
        [self selectImportViewIndex:self.pageView.index animate:YES];
        [scrollView scrollsToTop];
    } else if ((int)scrollView.contentOffset.x < (YYSCREEN_WIDTH *self.pageView.index)
               && self.pageView.index > 0) {
        self.pageView.index --;
        [self selectImportViewIndex:self.pageView.index animate:YES];
    }
}

- (void)selectImportViewIndex:(NSUInteger)index animate:(BOOL)isAnimate {
    [self.scrollView setContentOffset:CGPointMake(YYSCREEN_WIDTH *index, 0) animated:YES];
}

#pragma mark - YYPageViewDelegate

- (void)pageViewDidChangeIndex:(YYPageView *)pageView {
    [self.scrollView setContentOffset:CGPointMake(YYSCREEN_WIDTH *pageView.index, 0) animated:YES];
}

@end
