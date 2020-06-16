//
//  SettingRowModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WDSettingRowType) {
    WDSettingRowTypeNone,
    WDSettingRowTypeArrow,
    WDSettingRowTypeDesc,
    WDSettingRowTypeDescArrow,
    WDSettingRowTypeCustome,
    WDSettingRowTypeCheckbox,
};

@interface SettingRowModel : NSObject

@property(nonatomic,   copy) NSString          *title;
@property(nonatomic,   copy) NSString          *imageName;
@property(nonatomic, assign) WDSettingRowType  rowType;
@property(nonatomic,   copy) NSString          *desc;
@property(nonatomic, assign) BOOL              selected;
@property(nonatomic, assign) BOOL              isNeedUpgrade;
@property(nonatomic, assign, getter=isEnable)  BOOL enable;
@property(nonatomic, assign, getter=isVisible) BOOL visible;

@property(nonatomic, strong) NSNumber *value;


+ (instancetype)modelWithRowType:(WDSettingRowType)rowType;

+ (instancetype)modelWithTitle:(NSString *)title
                       rowType:(WDSettingRowType)rowType;

+ (instancetype)modelWithImageName:(NSString *)imageName
                             title:(NSString *)title
                           rowType:(WDSettingRowType)rowType;

+ (instancetype)modelWithTitle:(NSString *)title
                       rowType:(WDSettingRowType)rowType
                       visible:(BOOL)visible;

+ (instancetype)modelWithTitle:(NSString *)title
                          desc:(NSString *)desc
                       rowType:(WDSettingRowType)rowType;

+ (instancetype)modelWithTitle:(NSString *)title
                         value:(NSNumber *)value
                       rowType:(WDSettingRowType)rowType;

@end

NS_ASSUME_NONNULL_END
