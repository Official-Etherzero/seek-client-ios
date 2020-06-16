//
//  TxDetailView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/12/4.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TxDetailView.h"
#import "YYViewHeader.h"
#import "UILabel+Ext.h"

@interface TxDetailView ()

@property (nonatomic, strong) YYLabel *rightView;

@end

@implementation TxDetailView

- (instancetype)initWithFrame:(CGRect)frame
                         left:(NSString *)left
                        right:(NSString *)right {
    if (self = [super initWithFrame:frame]) {
        YYLabel *leftView = [[YYLabel alloc] init];
        leftView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:leftView];
        [leftView setTextColor:[UIColor grayColor]];
        leftView.font = FONT_DESIGN_24;
        leftView.text = left;
        CGFloat l_width = [leftView getWidthWithTitle:left font:FONT_DESIGN_24];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(l_width);
        }];
        
        YYLabel *rightView = [[YYLabel alloc] init];
//        rightView.numberOfLines = 0;
        rightView.textAlignment = NSTextAlignmentRight;
        [self addSubview:rightView];
        rightView.font = FONT_DESIGN_22;
        rightView.text = right;
        rightView.lineBreakMode = NSLineBreakByTruncatingMiddle;
//        CGFloat r_width = [rightView getWidthWithTitle:right font:FONT_DESIGN_20];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(self.frame.size.width - YYSIZE_25 - l_width);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
            make.left.right.mas_equalTo(self);
            make.size.mas_offset(CGSizeMake(self.frame.size.width, 1));
        }];
    }
    return self;
}

- (instancetype)initWithRightViewCanCopyFrame:(CGRect)frame
                                         left:(NSString *)left
                                        right:(NSString *)right {
    if (self = [super initWithFrame:frame]) {
        YYLabel *leftView = [[YYLabel alloc] init];
        leftView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:leftView];
        [leftView setTextColor:[UIColor grayColor]];
        leftView.font = FONT_DESIGN_24;
        leftView.text = left;
        CGFloat l_width = [leftView getWidthWithTitle:left font:FONT_DESIGN_24];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(l_width);
        }];
        
        YYLabel *rightView = [[YYLabel alloc] init];
        //        rightView.numberOfLines = 0;
        rightView.textAlignment = NSTextAlignmentRight;
        [self addSubview:rightView];
        rightView.font = FONT_DESIGN_22;
        rightView.text = right;
        rightView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        //        CGFloat r_width = [rightView getWidthWithTitle:right font:FONT_DESIGN_20];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(self.frame.size.width - YYSIZE_25 - l_width);
        }];
        self.rightView = rightView;
        self.rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(copyText)];
        [self.rightView addGestureRecognizer:tapGesture];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
            make.left.right.mas_equalTo(self);
            make.size.mas_offset(CGSizeMake(self.frame.size.width, 1));
        }];
    }
    return self;
}

- (void)copyText {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.rightView.text;
    if ([self.delegate respondsToSelector:@selector(yy_completeCopyCurrentText)]) {
        [self.delegate yy_completeCopyCurrentText];
    }
}


@end
