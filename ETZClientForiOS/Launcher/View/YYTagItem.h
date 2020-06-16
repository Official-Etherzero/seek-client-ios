//
//  YYTagItem.h
//  TAGViewDemo
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

#define showColor  [UIColor purpleColor]

NS_ASSUME_NONNULL_BEGIN
@class YYTagItem;

@protocol YYTagItemDelegate <NSObject>

- (void)yy_tagItem:(YYTagItem *)tagItem;

@end

@interface YYTagItem : UITextField<UITextFieldDelegate>

@property (nonatomic, assign) id<YYTagItemDelegate>tagDelegate;

@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, strong) UIColor * EditShowColor;


@end
NS_ASSUME_NONNULL_END
