//
//  TxDetailView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/12/4.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TxDetailViewDelegate <NSObject>

- (void)yy_completeCopyCurrentText;

@end

@interface TxDetailView : UIView

@property (nonatomic, weak) id<TxDetailViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame
                         left:(NSString *)left
                        right:(NSString *)right;

- (instancetype)initWithRightViewCanCopyFrame:(CGRect)frame
                                         left:(NSString *)left
                                        right:(NSString *)right;

@end

NS_ASSUME_NONNULL_END
