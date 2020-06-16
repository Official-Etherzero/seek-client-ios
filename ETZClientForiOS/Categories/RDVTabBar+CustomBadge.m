#import "RDVTabBar+CustomBadge.h"

@implementation RDVTabBar (CustomBadge)

- (void)setBadgeStryleIndex:(NSInteger)index tabbarNum:(NSInteger)tabbarNum {
    [self removeBadgeOnItemIndex:index];
    
    UILabel *label = [[UILabel alloc]init];
    label.tag = 1000 + index;
    label.layer.cornerRadius = 2.5;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    CGFloat percentX = (index + 0.6);
    CGFloat tabBarButtonW = CGRectGetWidth(tabFrame)/tabbarNum;
    CGFloat x = percentX *tabBarButtonW - 3;
    CGFloat y = 0.1 * CGRectGetHeight(tabFrame) + 6;
    label.frame = CGRectMake(x, y, 5, 5);
    
    [self addSubview:label];
    [self bringSubviewToFront:label];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 1000 +index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)hideBadgeOnIndex:(NSInteger)index {
    [self removeBadgeOnItemIndex:index];
}


@end
