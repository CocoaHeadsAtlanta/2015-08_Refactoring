//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    splitViewController.delegate = self;
    
    return YES;
}

#pragma mark - Split View Controller Delegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}

@end
