//
//  WDBaseFunctionController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "YYNavigationView.h"
#import "UIViewController+Ext.h"
#import "YYViewHeader.h"

@interface WDBaseFunctionController ()
<YYNavigationViewDelegate>

@property (nonatomic, strong) YYNavigationView *topView;

@end

@implementation WDBaseFunctionController

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.navigationItem.title = YYStringWithKey(title);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self yy_hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    self.topView.delegate = self;
    [self.topView returnButton];
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
