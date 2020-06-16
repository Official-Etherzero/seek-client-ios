//
//  YYNetworkInvalidView.m
//  Video_edit
//
//  Created by yang on 2018/9/25.
//  Copyright © 2018年 m-h. All rights reserved.
//

#import "YYNetworkInvalidView.h"
#import <BlocksKit/BlocksKit.h>
#import "Masonry.h"
#import "YYViewHeader.h"

@interface YYNetworkInvalidView ()

@property (nonatomic,  copy) RefreshBlock refreshBlock;

@end

@implementation YYNetworkInvalidView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithAttachView:(UIView *)attachView refresh:(RefreshBlock)refresh {
    if (self = [super init]) {
        self.refreshBlock = refresh;
        [attachView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(attachView);
            make.centerY.mas_equalTo(attachView.mas_centerY).offset(-YYSIZE_24);
            make.height.mas_offset(YYSIZE_200);
        }];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UIImageView *imageView = ({
        UIImageView *v = [[UIImageView alloc] init];
        [self addSubview:v];
        v.image = [UIImage imageNamed:@"common_nodata_cat"];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self);
        }];
        v;
    });
    
    UILabel *label = ({
        UILabel *v = [[UILabel alloc] init];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(imageView.mas_bottom).offset(YYSIZE_26);
        }];
        v.textColor = [UIColor whiteColor];
        [v setTextColor:COLOR_904818];
        v.font = [UIFont boldSystemFontOfSize:14.0];
        v.text = @"页面加载失败,请检查网络后再试吧~";
        v.textAlignment = NSTextAlignmentCenter;
        v;
    });
    
    __weak __typeof(&*self)weakSelf = self;
    UIButton *button = ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        [v.titleLabel setText:@"刷新一下"];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self);
            make.size.mas_offset(CGSizeMake(YYSIZE_96, YYSIZE_31));
        }];
        [v bk_addEventHandler:^(id  _Nonnull sender) {
            __strong typeof(weakSelf) self = weakSelf;
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self removeFromSuperview];
            self = nil;
        } forControlEvents:UIControlEventTouchUpInside];
        v;
    });
}

@end
