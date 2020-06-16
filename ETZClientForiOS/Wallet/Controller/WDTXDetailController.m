//
//  WDTXDetailController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/12/4.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDTXDetailController.h"
#import "YYViewHeader.h"
#import "TxDetailView.h"
#import "UIView+Ext.h"
#import "YYCalculateModel.h"
#import "WalletDataManager.h"
#import "NSString+Ext.h"
#import "YYToastView.h"
#import "YYDateModel.h"

@interface WDTXDetailController ()
<TxDetailViewDelegate>

@property (nonatomic, strong) TransferItem              *item;
@property (nonatomic, strong) UISwipeGestureRecognizer  *recognizer;

@end

@implementation WDTXDetailController

- (instancetype)initWithTransferItem:(TransferItem *)item {
    if (self = [super init]) {
        self.item = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    self.view.backgroundColor = COLOR_000000_A05;
    self.recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [self.recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:self.recognizer];
}

- (void)initSubViews {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_ffffff;
    bottomView.layer.cornerRadius = 10.0f;
    bottomView.clipsToBounds = YES;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_335, YYSIZE_560));
    }];
    
    // 判断是发送还是收款
    NSString *sendTitle;
    NSString *sendAddress;
    NSString *toTitle;
    NSString *compeleteTitle = @"完成";
    if ([[WalletDataManager accountModel].address isEqualToString:[self.item.to lowercaseString]]) {
        sendTitle = @"已发送";
        sendAddress = self.item.from;
        toTitle = @"从";
    } else if ([[WalletDataManager accountModel].address isEqualToString:[self.item.from lowercaseString]]) {
        sendTitle = @"已接收";
        sendAddress = self.item.to;
        toTitle = @"至";
    }
    // 正在发送
    if ([self.item.blockNumber isEqualToString:@"null"]
        || self.item.blockHash == nil) {
        sendTitle = @"发送中";
        compeleteTitle = @"初始化中";
    }
    
    UILabel *titleView = [[UILabel alloc] init];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = YYStringWithKey(sendTitle);
    titleView.font = FONT_DESIGN_28;
    [bottomView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
    }];
    
    YYButton *closeBtn = [YYButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:closeBtn];
    closeBtn.stretchLength = 8.0f;
    [closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeViewClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_08);
    }];
    
    NSString *total = [YYCalculateModel yy_calculateDividedWithNumString:self.item.value];
    UILabel *totalView = [[UILabel alloc] init];
    [bottomView addSubview:totalView];
    totalView.textAlignment = NSTextAlignmentCenter;
    [totalView setFont:FONT_PingFangSC_BLOD_32];
    totalView.text = [NSString stringWithFormat:@"%@ SEEK",total];
    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_20);
    }];
    
    NSString *pString = @"0";
    YYSettingLanguageType type = [[YYLanguageTool shareInstance] currentType];
    switch (type) {
        case YYSettingLanguageTypeChineseSimple: {
            pString = [NSString stringWithFormat:@"≈ ¥ %@",[pString yy_holdDecimalPlaceToIndex:5]];
        }
            break;
            
        case YYSettingLanguageTypeEnglish:{
            pString = [NSString stringWithFormat:@"≈ $ %@",[pString yy_holdDecimalPlaceToIndex:5]];
        }
            break;
        case YYSettingLanguageTypeKorea:{
            pString = [NSString stringWithFormat:@"≈ ₩ %@",[pString yy_holdDecimalPlaceToIndex:5]];
        }
            break;
        default: {
            pString = [NSString stringWithFormat:@"≈ $ %@",[pString yy_holdDecimalPlaceToIndex:5]];
        }
            break;
    }
    UILabel *priceView = [[UILabel alloc] init];
    [bottomView addSubview:priceView];
    priceView.textAlignment = NSTextAlignmentCenter;
    [priceView setFont:FONT_BEBAS_20];
    priceView.text = pString;
    [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.top.mas_equalTo(totalView.mas_bottom).offset(YYSIZE_05);
    }];
    
    TxDetailView *completeView = [[TxDetailView alloc] initWithFrame:CGRectMake(0, YYSIZE_120, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(compeleteTitle) right:[YYDateModel yy_getFullTimeWithTimeStamp:self.item.timestamp]];
    [bottomView addSubview:completeView];
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_ebecf0;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(completeView.mas_top).offset(-1);
        make.left.right.mas_equalTo(bottomView);
        make.size.mas_offset(CGSizeMake(YYSIZE_335, 1));
    }];
    
    TxDetailView *toView = [[TxDetailView alloc] initWithRightViewCanCopyFrame:CGRectMake(0, completeView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(toTitle) right:sendAddress];
    toView.delegate = self;
    [bottomView addSubview:toView];
    
    NSString *gasPrice = [NSString stringWithFormat:@"%@ gwei",[YYCalculateModel yy_calculateDividedByGasPrice:self.item.gasPrice]];
    TxDetailView *gasPriceView = [[TxDetailView alloc] initWithFrame:CGRectMake(0, toView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(@"gas价格") right:gasPrice];
    [bottomView addSubview:gasPriceView];
    
    TxDetailView *gaslimitView = [[TxDetailView alloc] initWithFrame:CGRectMake(0, gasPriceView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(@"gas上限") right:self.item.gas];
    [bottomView addSubview:gaslimitView];
    
    NSString *cost = [YYCalculateModel yy_calculateMultiplyedWithPrice:[YYCalculateModel yy_calculateDividedByGasPrice:self.item.gasPrice] limit:self.item.gas];
    TxDetailView *totalCostView = [[TxDetailView alloc] initWithFrame:CGRectMake(0, gaslimitView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(@"总费用") right:cost];
    [bottomView addSubview:totalCostView];
    
    TxDetailView *tView = [[TxDetailView alloc] initWithFrame:CGRectMake(0, totalCostView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(@"总计") right:[YYCalculateModel yy_calculateDividedWithNumString:self.item.value]];
    [bottomView addSubview:tView];
    
    TxDetailView *confirmView = [[TxDetailView alloc] initWithFrame:CGRectMake(0, tView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(@"已在区块中确认") right:self.item.blockNumber];
    [bottomView addSubview:confirmView];
    
    TxDetailView *transId = [[TxDetailView alloc] initWithRightViewCanCopyFrame:CGRectMake(0, confirmView.yy_bottom, YYSIZE_335, YYSIZE_50) left:YYStringWithKey(@"交易ID") right:self.item.hash];
    transId.delegate = self;
    [bottomView addSubview:transId];
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)closeViewClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TxDetailViewDelegate

- (void)yy_completeCopyCurrentText {
    [YYToastView showCenterWithTitle:YYStringWithKey(@"已复制到剪切板。") attachedView:self.view];
}

@end
