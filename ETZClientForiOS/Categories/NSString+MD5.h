//
//  NSString+MD5.h
//  01.Cookie的使用
//
//  Created by Yong Feng Guo on 14-12-14.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

+ (NSString *)DataTOjsonString:(id)object;

- (NSMutableDictionary *)getURLParameters;
@end
