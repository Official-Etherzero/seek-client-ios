//
//  WDVerifyMnemonicController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDVerifyMnemonicController.h"
#import "YYViewHeader.h"
#import "YYTagView.h"
#import "WDWalletViewController.h"
#import "WDTabbarController.h"
#import "WDWalletUserInfo.h"

@interface WDVerifyMnemonicController ()
<YYTagViewDelegate>

@property (nonatomic, strong) AccountModel     *model;
@property (nonatomic, strong) UIView           *bottomView;
@property (nonatomic, strong) UILabel          *centerLabel;
@property (nonatomic, strong) UILabel          *warnLabel;
@property (nonatomic, strong) YYTagView        *verifyView;
@property (nonatomic, strong) YYTagView        *chooseView;
@property (nonatomic, strong) UIButton         *confirmButton;
@property (nonatomic,   copy) NSArray          *mnemonicArr;

@end

@implementation WDVerifyMnemonicController

- (instancetype)initWithAccountModel:(AccountModel *)model {
    if (self = [super init]) {
        self.model = model;
        self.mnemonicArr = [self getRandomArrFrome:[model.mnemonicPhrase componentsSeparatedByString:@" "]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews {
    
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"验证助记词");

    self.bottomView = [UIView new];
    self.bottomView.layer.borderColor = COLOR_1a1a1a.CGColor;
    self.bottomView.layer.borderWidth = 0.5;
    self.bottomView.layer.cornerRadius = 2.0;
    self.bottomView.backgroundColor = COLOR_ffffff;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_25);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_25);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_250));
    }];
    
    self.centerLabel = [UILabel new];
    self.centerLabel.textColor = COLOR_a1a1a1;
    self.centerLabel.font = FONT_DESIGN_26;
    self.centerLabel.text = YYStringWithKey(@"请按顺序选择您的助记词");
    self.centerLabel.numberOfLines = 0;
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.centerLabel];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.width.mas_offset(YYSIZE_292);
    }];
    
    self.verifyView = [[YYTagView alloc] init];
    self.verifyView.Style = YYTagViewVerify;
    if (IS_IPHONE_X_orMore) {
        self.verifyView.frame = CGRectMake(YYSIZE_23, YYSIZE_90 + 25, YYSIZE_329, 0);
    } else {
        self.verifyView.frame = CGRectMake(YYSIZE_23, YYSIZE_90, YYSIZE_329, 0);
    }
    self.verifyView.delegate = self;
    [self.verifyView addTags:@[]];
    [self.view addSubview:self.verifyView];
    
    self.chooseView = [[YYTagView alloc] init];
    self.chooseView.Style = YYTagViewChoose;
    if (IS_IPHONE_X_orMore) {
        self.chooseView.frame = CGRectMake(YYSIZE_23, YYSIZE_364 + 22, YYSIZE_329, 0);
    } else {
        self.chooseView.frame = CGRectMake(YYSIZE_23, YYSIZE_364, YYSIZE_329, 0);
    }
    self.chooseView.delegate = self;
    [self.chooseView addTags:self.mnemonicArr];
    [self.view addSubview:self.chooseView];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.confirmButton];
    [self.confirmButton.titleLabel setFont:FONT_DESIGN_30];
    [self.confirmButton setBackgroundColor:COLOR_30D1A1];
    [self.confirmButton setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.confirmButton setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.confirmButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.confirmButton.layer setMasksToBounds:YES];
    self.confirmButton.layer.cornerRadius = 5.0f;
    [self.confirmButton setTitle:YYStringWithKey(@"前往验证") forState:UIControlStateNormal];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chooseView.mas_bottom).offset(YYSIZE_25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.enabled = NO;
    
    self.warnLabel = [UILabel new];
    self.warnLabel.textColor = COLOR_ff5959;
    self.warnLabel.font = FONT_DESIGN_24;
    self.warnLabel.text = YYStringWithKey(@"请输入正确的助记词 ！");
    [self.view addSubview:self.warnLabel];
    [self.warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chooseView.mas_bottom).offset(YYSIZE_10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_offset(YYSIZE_30);
    }];
    self.warnLabel.hidden = YES;
}

- (void)confirmClick:(UIButton *)btn {
    // 判断当前的助记词是不是正确的
    NSString *verifyStr = [self.verifyView.tagsArray componentsJoinedByString:@" "];
    if ([self.model.mnemonicPhrase isEqualToString:verifyStr]) {
        [UIApplication sharedApplication].delegate.window.rootViewController
        = [WDTabbarController setupViewControllersWithIndex:0];
        // 验证通过 添加到数据库
        [WDWalletUserInfo addAccount:self.model];
    } else {
        self.warnLabel.hidden = NO;
        [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.warnLabel.mas_bottom).offset(YYSIZE_25);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
        }];
        [self.confirmButton layoutIfNeeded];
    }
}

- (void)resetConfirmButtonFrame {
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chooseView.mas_bottom).offset(YYSIZE_25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.confirmButton layoutIfNeeded];
}

-(NSMutableArray *)getRandomArrFrome:(NSArray*)arr {
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}

#pragma mark - YYTagViewDelegate

- (void)YYTagView:(YYTagView *)tagView YYTagItem:(YYTagItem *)tagItem {
    if (tagView.Style == YYTagViewVerify) {
        [self.verifyView remove:tagItem.text];
        [self.chooseView addLabel:tagItem.text];
    } else {
        [self.chooseView remove:tagItem.text];
        [self.verifyView addLabel:tagItem.text];
    }
    
    if (self.verifyView.tagsArray && self.verifyView.tagsArray.count > 0) {
        self.centerLabel.hidden = YES;
    } else {
        self.centerLabel.hidden = NO;
    }
    if (self.chooseView.tagsArray.count == 0 && self.verifyView.tagsArray.count == 12) {
        self.confirmButton.enabled = YES;
    } else {
        if (self.warnLabel.hidden == NO) {
            [self resetConfirmButtonFrame];
            self.confirmButton.enabled = NO;
            self.warnLabel.hidden = YES;
        }
    }
}

@end
