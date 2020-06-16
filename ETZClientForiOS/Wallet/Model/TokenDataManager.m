//
//  TokenDataManager.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/2.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "TokenDataManager.h"
#import "YYDateModel.h"
#import "ClientServer.h"
#import "WalletDataManager.h"
#import "YYModel.h"
#import "YYInterfaceMacro.h"

@implementation TokenDataManager

+ (TokenItem *)updateDefaultTokenItemByModel:(AccountModel *)model {
    TokenItem *item = [[TokenItem alloc] init];
    item.name = @"SEEK";
    item.code = @"SeekChain";
    item.imageUrl = @"SEEK";
    item.num = model.balance;
    return item;
}
/** 这里是个测试数据, 这里有添加一个默认的数据*/
+ (NSArray<TokenItem *> *)getTokenList {
    NSMutableArray *arr = [NSMutableArray array];
    /** 第一位置默认数据 SEEK*/
    TokenItem *item = [[TokenItem alloc] init];
    item.name = @"SEEK";
    item.code = @"SeekChain";
    item.imageUrl = @"SEEK";
    /** 余额和金额要单独通过服务器去获取*/
    [arr addObject:item];
    /** 代币列表，再添加*/
    return arr;
}

+ (NSArray<TransferDetailItem *> *)getToeknTransferList {
    NSMutableArray *arr = [NSMutableArray array];
    TransferDetailItem *itme1 = [[TransferDetailItem alloc] init];
    itme1.status = YYTransferIng;
    itme1.date = [YYDateModel yy_currentTime];
    itme1.type = YYTransferPay;
    itme1.transAddress = @"0xadgfg3g4tgdfg3fgd244weg3";
    itme1.coinNum = 1233;
    
    TransferDetailItem *item2 = [[TransferDetailItem alloc] init];
    item2.status = YYTransferSuccess;
    item2.date = [YYDateModel yy_currentTime];
    item2.type = YYTransferCollection;
    item2.transAddress = @"0xgdjfjgdk3924fbdgdnfg32gf1";
    item2.coinNum = 58584;
    
    TransferDetailItem *item3 = [[TransferDetailItem alloc] init];
    item2.status = YYTransferFailure;
    item2.date = [YYDateModel yy_currentTime];
    item2.type = YYTransferCollection;
    item2.transAddress = @"0xdfgdfgdflgklk46346mnn324";
    item2.coinNum = 4755;
    
    TransferDetailItem *item4 = [[TransferDetailItem alloc] init];
    item2.status = YYTransferSuccess;
    item2.date = [YYDateModel yy_currentTime];
    item2.type = YYTransferPay;
    item2.transAddress = @"0xdfgdfgdfjhbcvc498235bcd2";
    item2.coinNum = 2566;
    
    [arr addObjectsFromArray:@[item2,item3,itme1,item4]];
    return arr;
}

+ (NSArray<TransferItem *> *)getTransferListByAccountModel:(AccountModel *)model {
    id object = [kUserDefaults objectForKey:model.address];
    NSMutableArray *list = [NSMutableArray array];
    NSArray *arr = [object objectForKey:@"result"];
    if (arr.count > 0) {
        for (id value in arr) {
            TransferItem *item = [TransferItem yy_modelWithJSON:value];
            [list addObject:item];
        }
    }
    return list;
}

#pragma warning TODO -


@end
