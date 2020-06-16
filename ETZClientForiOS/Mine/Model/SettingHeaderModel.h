//
//  SettingHeaderModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SettingRowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingHeaderModel : NSObject

@property(nonatomic, strong) UIImage                    *icon;
@property(nonatomic,   copy) NSString                   *title;
@property(nonatomic,   copy) NSArray<SettingRowModel *> *rows;
@property(nonatomic,   copy) NSString                   *desTitle;

+ (instancetype)modelWithTitle:(NSString *)title cells:(NSArray *)cells;

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title cells:(NSArray *)cells;

+ (instancetype)modelWithCells:(NSArray *)cells;

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title desTitle:(NSString *)desTitle cells:(NSArray *)cells;


@end

NS_ASSUME_NONNULL_END
