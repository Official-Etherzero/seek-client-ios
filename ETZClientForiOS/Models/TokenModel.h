//
//  TokenModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/17.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 代币 MODLE*/
NS_ASSUME_NONNULL_BEGIN

@interface TokenModel : NSObject

//@property (nonatomic,   copy) NSString *code;
//@property (nonatomic, strong) NSArray  *colors;
//@property (nonatomic,   copy) NSString *name;
//@property (nonatomic,   copy) NSString *address;
//@property (nonatomic,   copy) NSString *decimal;
//@property (nonatomic,   copy) NSString *logoUrl;
//@property (nonatomic,   copy) NSString *des;
//@property (nonatomic,   copy) NSString *symbol;
//@property (nonatomic,   copy) NSString *tokenId;

@property (nonatomic,   copy) NSString *address;
@property (nonatomic,   copy) NSString *colorLeft;
@property (nonatomic,   copy) NSString *colorRight;
@property (nonatomic,   copy) NSString *decimals;
@property (nonatomic,   copy) NSString *description;
@property (nonatomic,   copy) NSString *id;
@property (nonatomic,   copy) NSString *logoUrl;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *symbol;
@property (nonatomic,   copy) NSString *tokenABI;



@end

NS_ASSUME_NONNULL_END
