//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

@import UIKit;

@protocol FHKContactResultsViewControllerDelegate;

@interface FHKContactResultsViewController : UITableViewController <UISearchResultsUpdating>

@property (strong, nonatomic) NSString *cellIdentifier;
@property (weak, nonatomic) id<FHKContactResultsViewControllerDelegate> delegate;

+ (NSString *)storyboardIdentifier;

@end
