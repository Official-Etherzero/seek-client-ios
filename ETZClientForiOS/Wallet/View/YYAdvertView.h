//
//  YYAdvertView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/19.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYBottomSlideAnimationView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YYAdvertViewDelegate <NSObject>

- (void)yy_hideAdvertView;

@end

@interface YYAdvertView : YYBottomSlideAnimationView

@property (nonatomic, assign) id<YYAdvertViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
