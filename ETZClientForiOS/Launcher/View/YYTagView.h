//
//  YYTagView.h
//  TAGViewDemo
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTagItem.h"

@class YYTagView;
@class YYTagItem;
typedef NS_ENUM(NSInteger,YYTagViewStyle){
    // 区分两个不同的 tagView
    YYTagViewVerify = 0,// 待验证
    YYTagViewChoose = 1,// 选择
    
};

@protocol YYTagViewDelegate <NSObject>

- (void)YYTagView:(YYTagView *_Nonnull)tagView YYTagItem:(YYTagItem *_Nonnull)tagItem;

@end
NS_ASSUME_NONNULL_BEGIN


@interface YYTagView : UIView <YYTagItemDelegate>

@property(nonatomic   ,weak) id<YYTagViewDelegate> delegate;

@property(nonatomic, assign) YYTagViewStyle Style;

@property(nonatomic, strong) NSMutableArray * tagsArray;
@property(nonatomic, assign) CGFloat tagSpace;
@property(nonatomic, assign) CGFloat tagFontSize;
@property(nonatomic, assign) UIEdgeInsets padding;
@property(nonatomic, assign) UIEdgeInsets tagTextPadding;

- (void)addTags:(NSArray *)tags;

- (void)addLabel:(NSString *)text;

- (void)remove:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
