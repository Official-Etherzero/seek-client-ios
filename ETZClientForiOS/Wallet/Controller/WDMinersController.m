//
//  WDMinersController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDMinersController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "JavaScriptModel.h"
#import "YYInterfaceMacro.h"
#import "JSModel.h"
#import "YYModel.h"
#import "WalletDataManager.h"
#import "YYProgressLayer.h"
#import "YYViewHeader.h"

#import "YYNavigationView.h"
#import "UIViewController+Ext.h"
#import "WDSendViewController.h"

#define webUrl       @"http://seek.fh768.io/"
#define webIndex     @"http://seek.fh768.io/#/index"
#define webInfo      @"http://seek.fh768.io/#/info"
#define webRegister  @"http://seek.fh768.io/#/register"

@interface WDMinersController ()
<UIWebViewDelegate,
YYNavigationViewDelegate>

@property (nonatomic, strong) UIWebView                 *webView;
@property (nonatomic, strong) JSContext                 *context;
@property (nonatomic, strong) JavaScriptModel           *jsModel;
@property (nonatomic, strong) JSModel                   *model;
@property (nonatomic, strong) YYProgressLayer           *progressLayer;
@property (nonatomic, strong) YYNavigationView          *topView;
@property (nonatomic, assign) NSInteger                 requestAccount;
@property (nonatomic,   copy) NSString                  *currentUrl;

@end

@implementation WDMinersController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setMinerInfo:(NSString *)minerInfo {
    _minerInfo = minerInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.title = YYStringWithKey(@"矿工");
    self.requestAccount = 0;
    [self initSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyHashCallBack:) name:kTransferHash object:nil];
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

- (void)initSubViews {
    //    CGRect frame = CGRectMake(0, 0, YYSCREEN_WIDTH, YYSCREEN_HEIGHT-44);
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //    self.webView.frame = frame;
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:webIndex];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.topView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    self.topView.delegate = self;
    [self.topView returnButton];
}

- (void)showProgressLayer {
    if (!self.progressLayer) {
        if (IS_IPHONE_X_orMore) {
            self.progressLayer = [YYProgressLayer layerWithFrame:CGRectMake(0, 88, YYSCREEN_WIDTH, 2)];
        } else {
            self.progressLayer = [YYProgressLayer layerWithFrame:CGRectMake(0, 64, YYSCREEN_WIDTH, 2)];
        }
        [self.view.layer addSublayer:self.progressLayer];
        [self.progressLayer startLoad];
    }
}

- (void)removeProgressLayer {
    if (self.progressLayer) {
        [self.progressLayer closeTimer];
        [self.progressLayer removeFromSuperlayer];
        self.progressLayer = nil;
    }
}

- (void)onNotifyHashCallBack:(NSNotification *)notification {
    NSString *hash = notification.object[kTransferHashInfo];
    WDWeakify(self);
    dispatch_async_main_safe((^{
        WDStrongify(self);
        NSLog(@"传给 js 的hash值 %@",hash);
        JSValue *jsvalue = self.jsModel.jsContext[@"makeSaveData"];
        [jsvalue callWithArguments:@[hash,self.model.keyTime]];
    }));
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"当前加载的 url %@",request.URL.absoluteString);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showProgressLayer];
    [self setContext];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self removeProgressLayer];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    [self setContext];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"kkkkkkkkkkkkk %@",error);
    if (error.code == NSURLErrorCancelled
        || self.requestAccount < 3) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.currentUrl]]];
    }
    self.requestAccount ++;
    [self removeProgressLayer];
}

- (void)setContext {
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsModel = [[JavaScriptModel alloc] init];
    self.jsModel.minerInfo = self.minerInfo;
    self.jsModel.jsContext = self.context;
    [self.jsModel.jsContext setObject:self.jsModel forKeyedSubscript:@"easyetz"];
    WDWeakify(self);
    self.jsModel.sendTranscation = ^(NSString * _Nonnull jsons) {
        WDStrongify(self);
        self.model = [JSModel yy_modelWithJSON:jsons];
        dispatch_async_main_safe((^{
            WDSendViewController *vc = [[WDSendViewController alloc] initWithJsModel:self.model];
            self.definesPresentationContext = YES;
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有 ios8 later
            vc.view.backgroundColor = [COLOR_000000_A085 colorWithAlphaComponent:0.5];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }));
    };
    
    self.jsModel.landscapeBlock = ^{
        // 转横屏
        WDStrongify(self);
        dispatch_async_main_safe(^{
            if (iOS11) {
                self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
            [self yy_hideTabBar:YES];
            self.navigationController.navigationBar.hidden = YES;
            [self yy_interfaceOrientation:UIInterfaceOrientationLandscapeRight supportOrientationMask:UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight];
            self.webView.frame = self.view.bounds;
            [self.webView setNeedsLayout];
        });
    };
    
    self.jsModel.portraitBlock = ^{
        // 转竖屏
        WDStrongify(self);
        dispatch_async_main_safe(^{
            if (iOS11) {
                self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            }
            [self yy_interfaceOrientation:UIInterfaceOrientationPortrait  supportOrientationMask:UIInterfaceOrientationMaskPortrait];
        });
        self.webView.frame = self.view.bounds;
        [self.webView setNeedsLayout];
    };
    
    self.currentUrl = self.webView.request.URL.absoluteString;
    self.webView.frame = self.view.bounds;
    [self.webView setNeedsLayout];
    
    [self.jsModel.jsContext evaluateScript:self.currentUrl];
    [self.jsModel.jsContext setExceptionHandler:^(JSContext *context, JSValue *exception) {
//        WDStrongify(self);
//        NSLog(@"context:%@,exception:%@",context,exception);
    }];
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    NSString *cString = self.webView.request.URL.absoluteString;
    if ((cString &&
         [cString isEqualToString:webInfo]) ||
        [cString isEqualToString:webIndex] ||
        [cString isEqualToString:webRegister]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.webView.canGoBack) {
            [self.webView goBack];
        }
    }
}

@end
