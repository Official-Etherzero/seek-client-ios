//
//  SettingDataSource.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "SettingDataSource.h"
#import <BlocksKit/BlocksKit.h>

@implementation SettingDataSource

- (NSUInteger)numberOfSection {
    return _sections.count;
}

- (SettingHeaderModel *)sectionModelWithSection:(NSInteger)section {
    return _sections[section];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self sectionModelWithSection:section].rows.count;
}

- (SettingRowModel *)rowWithIndexPath:(NSIndexPath *)path {
    return [self sectionModelWithSection:path.section].rows[path.row];
}

- (void)selectedAllRow:(BOOL)selected {
    [self.sections bk_each:^(SettingHeaderModel *obj) {
        [obj.rows bk_each:^(SettingRowModel *row) {
            row.selected = selected;
        }];
    }];
}

- (SettingRowModel *)selectedRow {
    __block SettingRowModel *result = nil;
    [self.sections enumerateObjectsUsingBlock:^(SettingHeaderModel * _Nonnull header, NSUInteger idx, BOOL * _Nonnull oStop) {
        [header.rows enumerateObjectsUsingBlock:^(SettingRowModel * _Nonnull row, NSUInteger idx, BOOL * _Nonnull iStop) {
            if (row.selected) {
                result = row;
                *oStop = YES;
                *iStop = YES;
            }
        }];
    }];
    return result;
}

@end
