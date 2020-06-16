#import "RDVTabBar.h"

@interface RDVTabBar (CustomBadge)

/** show little red dot */
- (void)setBadgeStryleIndex:(NSInteger)index tabbarNum:(NSInteger)tabbarNum;

/** hidden the red dot */
- (void)hideBadgeOnIndex:(NSInteger)index;

@end
