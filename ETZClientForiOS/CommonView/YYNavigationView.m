//
//  YYNavigationView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYNavigationView.h"
#import "YYViewHeader.h"
#import "UIImage+Ext.h"
#import "UIButton+Ext.h"
#import "UIBarButtonItem+Ext.h"
#import "YYLanguageTool.h"

@implementation YYNavigationView{
    __weak UINavigationItem *_item;
}

- (instancetype)initWithNavigationItem:(UINavigationItem *)item {
    self = [self init];
    if (self) {
        _item = item;
    }
    return self;
}

- (void)confirm {
    UIButton *cancelButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:YYStringWithKey(@"取消") forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_05b27e forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_DESIGN_30;
        [btn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchDown];
        btn;
    });
    [cancelButton sizeToFit];
    
    UIButton *saveButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:YYStringWithKey(@"完成") forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_05b27e forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_a9a9a9 forState:UIControlStateDisabled];
        btn.titleLabel.font = FONT_DESIGN_30;
        [btn addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchDown];
        btn;
    });
    [saveButton sizeToFit];
    _saveButton = saveButton;
    _item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    _item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    _item.rightBarButtonItem.enabled = NO;
    
}

- (void)returnButton {
    _item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage yy_imageRenderOriginalWithName:@"back"]
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(navigationBackClick)];
}

- (void)customReturnButton {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    UIButton *returnButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3.5,0, 3.5, 7)];
        btn.frame = contentView.bounds;
        [btn setImage:[UIImage imageNamed:@"Nav_menu_return_btn"]
             forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(navigationBackClick) forControlEvents:UIControlEventTouchDown];
        btn;
    });
    [returnButton yy_centerButtonAndImageWithSpacing:10];
    [contentView addSubview:returnButton];
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    if (IS_OS_11_OR_LATER) {
        [_item setLeftBarButtonItems:@[returnItem]];
    } else {
        [_item setLeftBarButtonItems:@[[UIBarButtonItem fixedSpaceWithWidth:-15],returnItem] animated:YES];
    }
}

- (void)adapterNavigationBar {
    
    NSArray * array = _item.leftBarButtonItems;
    if (array && array.count != 0){
        UIBarButtonItem * buttonItem = array[0];
        UIView * view = [[[buttonItem.customView superview] superview] superview];
        NSArray * arrayConstraint = view.constraints;
        for (NSLayoutConstraint * constant in arrayConstraint) {
            if (fabs(constant.constant) == 16 || fabs(constant.constant) == 20) {
                constant.constant = 0;
            }
        }
    }
}

- (void)dismiss {
    UIButton *dismissButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"WiFiset_Reconnect_close_btn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchDown];
        btn;
    });
    [dismissButton sizeToFit];
    _item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:dismissButton];
}

- (void)navigationBackClick {
    if ([self.delegate respondsToSelector:@selector(yyNavigationViewReturnClick:)]) {
        [self.delegate yyNavigationViewReturnClick:self];
    }
}

- (void)saveButtonClick {
    if ([self.delegate respondsToSelector:@selector(yyNavigationViewConfirmClick:)]) {
        [self.delegate yyNavigationViewConfirmClick:self];
    }
}

- (void)cancelButtonClick {
    if ([self.delegate respondsToSelector:@selector(yyNavigationViewCancelClick:)]) {
        [self.delegate yyNavigationViewCancelClick:self];
    }
}

- (void)setReturnButtonEnable:(BOOL)isEnable{
    _item.leftBarButtonItem.enabled = isEnable;
}


@end
