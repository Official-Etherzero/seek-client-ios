//
//  WDDiscoverViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDDiscoverViewController.h"
#import <WebKit/WebKit.h>
#import "YYViewHeader.h"
#import "WDSendViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JavaScriptModel.h"
#import "YYInterfaceMacro.h"
#import "UIViewController+Ext.h"
#import "JSModel.h"
#import "YYModel.h"
#import "WalletDataManager.h"
#import "YYProgressLayer.h"
#import "NSString+Ext.h"

@interface WDDiscoverViewController ()
<UIWebViewDelegate,
UISearchBarDelegate>

@property (nonatomic, strong) UIWebView                 *webView;
@property (nonatomic, strong) UIProgressView            *progressView;
@property (nonatomic, strong) JSContext                 *context;
@property (nonatomic, strong) JavaScriptModel           *jsModel;
@property (nonatomic, strong) UIButton                  *backBtn;
@property (nonatomic, strong) UIButton                  *closeBtn;
@property (nonatomic, strong) JSModel                   *model;
@property (nonatomic, strong) YYProgressLayer           *progressLayer;
@property (nonatomic, strong) UISearchBar               *searchBar;

@end

@implementation WDDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_000000;
    [self initSubViews];
}

- (void)initSubViews {
    [self setWebView];
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [self.backBtn addTarget:self action:@selector(backClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [self.closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateHighlighted];
    [self.closeBtn addTarget:self action:@selector(closeClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.frame = CGRectMake(0, 2, YYSCREEN_WIDTH - 140, 35);
    self.searchBar.delegate = self;
    self.searchBar.showsScopeBar = YES;
    
    UIView *titileView = [UIView new];
    titileView.frame = CGRectMake(0, 0, YYSCREEN_WIDTH- 140, 44);
    [titileView addSubview:self.searchBar];
    self.navigationItem.titleView = titileView;
    
    self.backBtn.hidden = YES;
    self.closeBtn.hidden = YES;
    
    UIBarButtonItem *spaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBarButton.width = 15;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
    self.navigationItem.leftBarButtonItems = @[spaceBarButton,leftItem,rightItem];
}

- (void)setWebView {
//    CGRect frame = CGRectMake(0, 0, YYSCREEN_WIDTH, YYSCREEN_HEIGHT-44);
    self.webView = [[UIWebView alloc] init];
//    self.webView.frame = frame;
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://seek.fh768.io/#/find"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)backClickAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (void)closeClickAction {
    NSURL *url = [NSURL URLWithString:@"http://seek.fh768.io/#/find"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.backBtn.hidden = YES;
    self.closeBtn.hidden = YES;
    [self yy_hideTabBar:NO];
}

- (void)showProgressLayer {
    if (!self.progressLayer) {
        if (IS_IPHONE_X_orMore) {
            self.progressLayer = [YYProgressLayer layerWithFrame:CGRectMake(0, 84, YYSCREEN_WIDTH, 2)];
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

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [self showProgressLayer];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self removeProgressLayer];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setContext];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self removeProgressLayer];
}

- (void)setContext {
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsModel = [[JavaScriptModel alloc] init];
    self.jsModel.jsContext = self.context;
    [self.jsModel.jsContext setObject:self.jsModel forKeyedSubscript:@"easyetz"];
    WDWeakify(self);
    self.jsModel.sendTranscation = ^(NSString * _Nonnull jsons) {
        WDStrongify(self);
        self.model = [JSModel yy_modelWithJSON:jsons];
        dispatch_async_main_safe((^{
            WDSendViewController *vc = [[WDSendViewController alloc] initWithJsModel:self.model];
            vc.hashCallback = ^(NSString * _Nonnull hashString) {
                JSValue *jsvalue = self.jsModel.jsContext[@"makeSaveData"];
                //            JSValue *jsvalue = [self.jsModel.jsContext objectForKeyedSubscript:@"\('makeSaveData')"];
                [jsvalue callWithArguments:@[hashString,self.model.keyTime]];
            };
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
            self.backBtn.hidden = YES;
            self.closeBtn.hidden = YES;
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
        self.backBtn.hidden = NO;
        self.closeBtn.hidden = NO;
        self.webView.frame = self.view.bounds;
        [self.webView setNeedsLayout];
    };
    
    NSString *curUrl = self.webView.request.URL.absoluteString;
    if ([curUrl containsString:@"http://seek.fh768.io/#/find"]) {
        [self yy_hideTabBar:NO];
        self.backBtn.hidden = YES;
        self.closeBtn.hidden = YES;
    } else if (YYSCREEN_HEIGHT > YYSCREEN_WIDTH) {
        // 返回竖屏
        if (self.backBtn.hidden) {
            [self yy_hideTabBar:YES];
            self.backBtn.hidden = NO;
            self.closeBtn.hidden = NO;
        }
    }
    self.webView.frame = self.view.bounds;
    [self.webView setNeedsLayout];
    
    [self.jsModel.jsContext evaluateScript:curUrl];
    [self.jsModel.jsContext setExceptionHandler:^(JSContext *context, JSValue *exception) {
        NSLog(@"context:%@,exception:%@",context,exception);
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    if (searchBar.text && searchBar.text.length > 0 && [searchBar.text yy_isValidUrl]) {
        // 如果是一个 url 则进行加载
        NSURL *url = [NSURL URLWithString:self.searchBar.text];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"found"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"found_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"发现");
}
@end
