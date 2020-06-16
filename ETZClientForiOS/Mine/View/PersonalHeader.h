//
//  PersonalHeader.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalHeader : UITableViewHeaderFooterView

@property(nonatomic, strong, readonly) UILabel *titleView;
@property(nonatomic, strong) SettingHeaderModel *model;

+ (NSString *)identifier;

+ (CGFloat)height;

@end

NS_ASSUME_NONNULL_END
