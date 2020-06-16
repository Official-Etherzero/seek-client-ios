//
//  PersonalCenterCell.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterCell : UITableViewCell

@property(nonatomic, strong) SettingRowModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
