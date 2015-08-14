//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "AddressBook-Swift.h"

@interface AppDelegate ()

@property (strong, nonatomic) SplitViewControllerDelegate *splitViewControllerDelegate;

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SplitViewControllerDelegate *delegate = [[SplitViewControllerDelegate alloc] init];
    self.splitViewControllerDelegate = delegate;
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    splitViewController.delegate = self.splitViewControllerDelegate;
    
    return YES;
}

@end
