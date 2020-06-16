#import "NSDictionary+Ext.h"
#import "NSString+Ext.h"

@implementation NSDictionary (Ext)

- (NSArray *)yy_sortedKeys {
    NSArray *keyArray = self.allKeys;
    if (![keyArray.firstObject isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSArray *arr = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1,NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    return arr;
}

@end
