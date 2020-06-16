//
//  JavaScriptModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/10/8.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JavaScriptModelDelegate <JSExport>

- (void)etzTransaction:(NSString *_Nonnull)jsons;
- (NSString *_Nonnull)getAddress;
- (void)landscapeAndHideTitle;
- (void)backToPortrait;
- (NSString *_Nonnull)getCurrentLanguage;
- (NSString *_Nonnull)getMinerInfo;

@end

NS_ASSUME_NONNULL_BEGIN

@interface JavaScriptModel : NSObject<JavaScriptModelDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic,   copy) void(^sendTranscation)(NSString *jsons);
@property (nonatomic,   copy) void(^landscapeBlock)(void);
@property (nonatomic,   copy) void(^portraitBlock)(void);
@property (nonatomic,   copy) NSString *minerInfo;

@end

NS_ASSUME_NONNULL_END
