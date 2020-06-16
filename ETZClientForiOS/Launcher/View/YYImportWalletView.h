//
//  YYImportWalletView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/21.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYImportInfo.h"

NS_ASSUME_NONNULL_BEGIN
@class YYImportWalletView;
@class YYImportInfo;

@protocol YYImportWalletViewDelegate <NSObject>

- (void)yy_importWalletWithImportInfo:(YYImportInfo *)info;

@end

@interface YYImportWalletView : UIView

@property (nonatomic, assign) id<YYImportWalletViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame
                        style:(YYImportStyle)style
                       desStr:(NSString *)desStr;

- (instancetype)initWithAttackView:(UIView *)attackView
                              info:(YYImportInfo *)info
                            desStr:(NSString *)desStr;



@end

NS_ASSUME_NONNULL_END
