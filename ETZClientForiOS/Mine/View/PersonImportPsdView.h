//
//  PersonImportPsdView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/10.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonImportPsdView : UIView

@property (nonatomic,  copy) void(^cancelClickBlock)(void);
@property (nonatomic,  copy) void(^confirmClickBlock)(NSString *content);


@end

NS_ASSUME_NONNULL_END
