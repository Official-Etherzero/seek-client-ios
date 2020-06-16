#import "UINavigationController+Ext.h"

@implementation UINavigationController (Ext)

- (CGFloat)yy_navigationBarHeight {
    if (self.navigationBar) {
        return self.navigationBar.frame.size.height;
    } else {
        return [UINavigationBar appearance].frame.size.height;
    }
}

@end
