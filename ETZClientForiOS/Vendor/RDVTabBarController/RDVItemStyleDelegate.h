//
// Created by MacBook on 2016/11/22.
// Copyright (c) 2016 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RDVItemStyleDelegate <NSObject>

@required
- (nonnull UIImage *)rdvItemNormalImage;

- (nonnull UIImage *)rdvItemHighLightImage;

- (nullable NSString *)rdvItemTitle;

@end


@protocol RDVItemStylePopDelegate <NSObject>



@end
