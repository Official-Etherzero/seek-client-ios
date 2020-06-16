//
//  WDScanCodeController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDScanCodeController.h"
#import "YYViewHeader.h"
#import "SGQRCode.h"
#import "YYInterfaceMacro.h"
#import "WDTransferController.h"

@interface WDScanCodeController ()

@property (nonatomic, strong) SGQRCodeObtain        *obtain;
@property (nonatomic, strong) AVCaptureSession      *session;  // 会话
@property (nonatomic, strong) AVCaptureDeviceInput  *input;    // 输入流
@property (nonatomic, strong) SGQRCodeScanView      *scanView;  // 预览视图
@property (nonatomic, strong) UIButton              *cancelBtn;
@property (nonatomic, assign) BOOL                  stop;

@end

@implementation WDScanCodeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 二维码开启方法
    [self.obtain startRunningWithBefore:nil completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];
    [self.obtain stopRunning];
}

- (void)dealloc {
    [self removeScanningView];
}

- (void)removeScanningView {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_000000_A08;
    [self setupQRCodeScan];
    [self initSubViews];
}

- (void)initSubViews {
    self.scanView = [[SGQRCodeScanView alloc] init];
    [self.view addSubview:self.scanView];
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.cancelBtn];
    [self.cancelBtn setTitle:YYStringWithKey(@"取消") forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:COLOR_30d1a1 forState:UIControlStateNormal];
    [self.cancelBtn.titleLabel setFont:FONT_DESIGN_54];
    self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-70);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-70);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.cancelBtn addTarget:self action:@selector(cancelScanClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupQRCodeScan {
    self.obtain = [SGQRCodeObtain QRCodeObtain];
    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.sampleBufferDelegate = YES;
    [self.obtain establishQRCodeObtainScanWithController:self configure:configure];
    WDWeakify(self)
    [self.obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        WDStrongify(self)
        if (result) {
            [self.obtain stopRunning];
//            [obtain playSoundName:@"SGQRCode.bundle/sound.caf"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 扫成功了，接下来要干嘛，再说吧
                [self.navigationController pushViewController:[[WDTransferController alloc] initWithScanString:result] animated:YES];
#warning TODO
            });
        }
    }];
}

- (void)cancelScanClick {
    // 结束扫描
    [self.navigationController popViewControllerAnimated:YES];
}

@end

