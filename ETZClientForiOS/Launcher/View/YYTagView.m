//
//  YYTagView.m
//  TAGViewDemo
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYTagView.h"
#import "YYViewHeader.h"

@implementation YYTagView

- (instancetype)init {
    if (self = [super init]) {
        self.tagFontSize = 12;
        self.tagSpace = 10;
        self.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        self.tagsArray = [NSMutableArray array];
        self.backgroundColor = COLOR_ffffff;
    }
    return self;
}

- (void)remove:(NSString *)text {
    for (YYTagItem *item in self.subviews) {
        if([self stringIsEquals:item.text to:text]) {
            [item removeFromSuperview];
            [self.tagsArray removeObject:text];
            break;
        }
    }
}

- (void)addTags:(NSArray *)tags {
    if (tags.count > 0) {
        [self.tagsArray removeAllObjects];
        for (int i = 0; i< tags.count; i++) {
            [self addLabel:tags[i]];
        }
    }
}

- (void)addLabel:(NSString *)text {
    [self.tagsArray addObject:text];
    CGRect frame = CGRectZero;
    if(self.subviews && self.subviews.count > 0) {
        frame = [self.subviews lastObject].frame;
    }
    
    YYTagItem *Item = [[YYTagItem alloc] init];
    Item.layer.cornerRadius = 5;
    UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    Item.rightView = rightVeiw;
    Item.rightViewMode = UITextFieldViewModeAlways;
    Item.padding = UIEdgeInsetsMake(10, 10, 10, 26);
    if (self.Style == YYTagViewChoose) {
        Item.layer.borderColor = COLOR_30D1A1.CGColor;
        Item.layer.borderWidth = 0.5;
        Item.layer.cornerRadius = 3.0;
        Item.EditShowColor = COLOR_ffffff;
        Item.textColor = COLOR_30D1A1;
    } else {
        Item.layer.cornerRadius = 3.0;
        Item.EditShowColor = COLOR_30D1A1;
        Item.textColor = COLOR_ffffff;
    }
    Item.text = text;
    Item.tagDelegate = self;
    Item.frame = CGRectMake(frame.origin.x, frame.origin.y, Item.frame.size.width, Item.frame.size.height);
    [Item sizeToFit];
    [self addSubview:Item];
}

- (void)layoutSubviews {
    [UIView beginAnimations:nil context:nil];
    CGFloat paddingRight = self.padding.right;
    CGFloat cellspace = 5;
    CGFloat y = self.padding.top;
    CGFloat x = self.padding.left;
    CGRect frame;
    for(UIView *tag in self.subviews) {
        frame = tag.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        if(frame.origin.x + frame.size.width + paddingRight > self.frame.size.width) {
            frame.origin.x = self.padding.left;
            frame.origin.y = frame.origin.y + frame.size.height + cellspace;
            y = frame.origin.y;
        }
        if(frame.origin.x + frame.size.width > self.frame.size.width - paddingRight) {
            frame.size.width = self.frame.size.width - paddingRight - frame.origin.x;
        }
        x = frame.origin.x + frame.size.width + cellspace;
        tag.frame = frame;
    }
    CGFloat containerHeight = frame.origin.y + frame.size.height + self.padding.bottom;
    CGRect containerFrame = self.frame;
    if (self.subviews.count == 0) {
        containerHeight = 10;
    }
    containerFrame.size.height = containerHeight;
    self.frame = containerFrame;
    [UIView commitAnimations];
}

#pragma mark - YYTagItemDelegate

- (void)yy_tagItem:(YYTagItem *)tagItem {
    if([self.delegate respondsToSelector:@selector(YYTagView:YYTagItem:)]) {
        [self.delegate YYTagView:self YYTagItem:tagItem];
    }
}

#pragma mark -

- (BOOL)stringIsEquals:(NSString *)string to:(NSString *)string2 {
    return [string isEqualToString:string2];
}


@end
