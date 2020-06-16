//
//  WDMnemonicController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDMnemonicController.h"
#import "YYViewHeader.h"
#import "WDVerifyMnemonicController.h"

@interface WDMnemonicController ()

@property (nonatomic, strong) UITextView       *textView;
@property (nonatomic, strong) UIButton         *validationBtn;
@property (nonatomic, strong) AccountModel     *model;

@end

@implementation WDMnemonicController

- (instancetype)initWithAccountModel:(AccountModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews {
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = YYStringWithKey(@"助记词");
    
    self.textView = [UITextView new];
    [self.view addSubview:self.textView];
    self.textView.layer.borderColor = COLOR_1a1a1a.CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 2.0;
    self.textView.textAlignment = NSTextAlignmentLeft;
    [self.textView setFont:FONT_DESIGN_30];
    self.textView.textContainerInset = UIEdgeInsetsMake(23, 27, 23,26);
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_25);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_25);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_120));
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 15;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.model.mnemonicPhrase attributes:attributes];
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_DESIGN_24;
    label.textColor = COLOR_ff5959;
    label.text = YYStringWithKey(@"助记词用于恢复账户，请保管好助记词，以免造成资产损失！");
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(YYSIZE_02);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_40));
    }];
    
    self.validationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.validationBtn];
    [self.validationBtn.titleLabel setFont:FONT_DESIGN_30];
    [self.validationBtn setBackgroundColor:COLOR_30D1A1];
    [self.validationBtn setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.validationBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.validationBtn setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.validationBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.validationBtn.layer setMasksToBounds:YES];
    self.validationBtn.layer.cornerRadius = 5.0f;
    [self.validationBtn setTitle:YYStringWithKey(@"前往验证") forState:UIControlStateNormal];
    [self.validationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(YYSIZE_25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_50));
    }];
    [self.validationBtn addTarget:self action:@selector(validationClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)validationClick:(UIButton *)btn {
    WDVerifyMnemonicController *vc = [[WDVerifyMnemonicController alloc] initWithAccountModel:self.model];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
