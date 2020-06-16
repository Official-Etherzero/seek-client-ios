//
//  SettingHeaderModel.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "SettingHeaderModel.h"

@implementation SettingHeaderModel

+ (instancetype)modelWithTitle:(NSString *)title cells:(NSArray *)cells {
    SettingHeaderModel *model = [[SettingHeaderModel alloc] init];
    model.title = title;
    model.rows = cells;
    return model;
}

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title cells:(NSArray *)cells {
    SettingHeaderModel *model = [[SettingHeaderModel alloc] init];
    model.icon = [UIImage imageNamed:imageName];
    model.title = title;
    model.rows = cells;
    return model;
}

+ (instancetype)modelWithCells:(NSArray *)cells {
    SettingHeaderModel *model = [[SettingHeaderModel alloc] init];
    model.rows = cells;
    return model;
}

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title desTitle:(NSString *)desTitle cells:(NSArray *)cells{
    SettingHeaderModel *model = [[SettingHeaderModel alloc] init];
    model.icon = [UIImage imageNamed:imageName];
    model.title = title;
    model.rows = cells;
    model.desTitle = desTitle;
    return model;
}


@end
