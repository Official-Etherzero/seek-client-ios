#import "UITableViewController+Ext.h"

@implementation UITableViewController (Ext)

- (void)yy_reloadWithIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
