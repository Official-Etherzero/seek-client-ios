//
//  SettingDataSource.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingDataSource : NSObject

@property(nonatomic, strong) NSMutableArray<SettingHeaderModel *> *sections;

- (NSUInteger)numberOfSection;

- (SettingHeaderModel *)sectionModelWithSection:(NSInteger)section;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (SettingRowModel *)rowWithIndexPath:(NSIndexPath *)path;

- (void)selectedAllRow:(BOOL)selected;

- (SettingRowModel *)selectedRow;


@end

NS_ASSUME_NONNULL_END
