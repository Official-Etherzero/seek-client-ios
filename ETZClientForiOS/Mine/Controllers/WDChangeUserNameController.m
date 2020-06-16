//
//  WDChangeUserNameController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/11/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDChangeUserNameController.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "WDWalletUserInfo.h"
#import "YYToastView.h"

@interface WDChangeUserNameController ()
<UITextViewDelegate>

@property (nonatomic, strong) AccountModel  *model;
@property (nonatomic, strong) YYTextView    *textView;

@end

@implementation WDChangeUserNameController

- (instancetype)initWithAccount:(AccountModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yy_colorWithR:237 g:237 b:237];
    [self initSubViews];
}

- (void)initSubViews {
    // 导航栏
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:YYStringWithKey(@"取消") forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:FONT_DESIGN_30];
    cancelBtn.frame = CGRectMake(0, 0, 40, 26);
    [cancelBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(0, 0, 40, 26);
    completeBtn.layer.cornerRadius = 5;
    completeBtn.backgroundColor = COLOR_30D1A1;
    [completeBtn.titleLabel setFont:FONT_DESIGN_30];
    [completeBtn setTitle:YYStringWithKey(@"完成") forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    
    self.textView = [YYTextView new];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.height.mas_offset(YYSIZE_40);
    }];
    self.textView.backgroundColor = COLOR_ffffff;
    self.textView.textColor = COLOR_1a1a1a;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.placeholderColor = COLOR_1a1a1a;
    self.textView.font = FONT_DESIGN_30;
    self.textView.text = self.model.userName;
    [self.textView becomeFirstResponder];
}

- (void)cancelClickAction {
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)completeClickAction {
    // 插入数据库
    [self.textView resignFirstResponder];
    if (self.textView.text.length == 0) {
        //
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入备注名") attachedView:self.view];
        return;
    }
    if (self.textView.text.length > 0) {
        self.model.userName = self.textView.text;
    }
    if (self.exitCallback) {
        self.exitCallback(self.model);
    }
    [WDWalletUserInfo updateAccount:self.model];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
}




@end
