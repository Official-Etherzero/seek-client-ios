//
//  SettingRowModel.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "SettingRowModel.h"
#import "YYSettingLanguage.h"

@implementation SettingRowModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.visible = YES;
    }
    return self;
}

+ (instancetype)modelWithTitle:(NSString *)title rowType:(WDSettingRowType)rowType visible:(BOOL)visible {
    SettingRowModel *row = [self modelWithTitle:title rowType:rowType];
    row.visible = visible;
    return row;
}

+ (instancetype)modelWithRowType:(WDSettingRowType)rowType {
    SettingRowModel *row = [[SettingRowModel alloc] init];
    row.rowType = rowType;
    return row;
}

+ (instancetype)modelWithTitle:(NSString *)title rowType:(WDSettingRowType)rowType {
    SettingRowModel *row = [[SettingRowModel alloc] init];
    row.title = title;
    row.rowType = rowType;
    return row;
}

+ (instancetype)modelWithImageName:(NSString *)imageName
                             title:(NSString *)title
                           rowType:(WDSettingRowType)rowType {
    SettingRowModel *row = [[SettingRowModel alloc] init];
    row.imageName = imageName;
    row.title = title;
    row.rowType = rowType;
    return row;
}


+ (instancetype)modelWithTitle:(NSString *)title desc:(NSString *)desc rowType:(WDSettingRowType)rowType {
    SettingRowModel *row = [[SettingRowModel alloc] init];
    row.title = title;
    row.rowType = rowType;
    row.desc = desc;
    return row;
}

+ (instancetype)modelWithTitle:(NSString *)title value:(NSNumber *)value rowType:(WDSettingRowType)rowType {
    SettingRowModel *row = [[SettingRowModel alloc] init];
    row.title = title;
    row.rowType = rowType;
    row.value = value;
    return row;
}

- (BOOL)isEnable {
    return _enable;
}

- (BOOL)isVisible {
    return _visible;
}


@end
