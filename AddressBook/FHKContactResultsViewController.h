//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

@import UIKit;

@class FHKContact;

@protocol FHKContactResultsViewControllerDelegate;

@interface FHKContactResultsViewController : UITableViewController <UISearchResultsUpdating>

@property (weak, nonatomic) id<FHKContactResultsViewControllerDelegate> delegate;

@end
