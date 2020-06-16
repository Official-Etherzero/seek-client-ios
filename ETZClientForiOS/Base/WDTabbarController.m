//
//  WDTabbarController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDTabbarController.h"
#import "RDVTabBarController.h"
#import "WDMineViewController.h"
#import "WDWalletViewController.h"
#import "WDDiscoverViewController.h"

@implementation WDTabbarController

+ (UIViewController *)setupViewControllersWithIndex:(NSUInteger)index {
    UIViewController *firstVC = [[WDWalletViewController alloc] init];
    UIViewController *navigationFirstVC = [[UINavigationController alloc]
                                            initWithRootViewController:firstVC];
    
    WDDiscoverViewController *secondVC = [[WDDiscoverViewController alloc] init];
    UIViewController *navigationSecondVC = [[UINavigationController alloc]
                                           initWithRootViewController:secondVC];
    
    WDMineViewController *thirdVC = [[WDMineViewController alloc] init];
    
    UIViewController *navigationThirdVC = [[UINavigationController alloc]
                                           initWithRootViewController:thirdVC];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[navigationFirstVC,
                                           navigationSecondVC,
                                           navigationThirdVC]];
    [tabBarController.tabBar setHeight:49];
    [tabBarController setSelectedIndex:index];
    return tabBarController;
}

@end
