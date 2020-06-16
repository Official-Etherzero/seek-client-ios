
#import "UINavigationBar+Ext.h"
#import <objc/runtime.h>
@implementation UINavigationBar (Ext)
//+(void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self swizzleInstanceMethodWithOriginSel:@selector(layoutSubviews)
//                                     swizzledSel:@selector(yy_layoutSubviews)];
//    });
//}

+ (void)swizzleInstanceMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzled {
    Method originalMethod = class_getInstanceMethod([self class], originSel);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzled);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

-(void)yy_layoutSubviews{
    [self yy_layoutSubviews];
    NSInteger deviceVersion = [UIDevice currentDevice ].systemVersion.integerValue;
    if (deviceVersion>= 11) {
        self.layoutMargins = UIEdgeInsetsZero;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsZero;//可修正iOS11之后的偏移
            }
        }
    }
}

@end
