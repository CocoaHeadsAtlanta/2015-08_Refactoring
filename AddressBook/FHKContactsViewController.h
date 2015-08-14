//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

@import UIKit;

#import "FHKContactResultsViewController.h"

@interface FHKContactsViewController : UITableViewController <FHKContactResultsViewControllerDelegate>

@property (strong, nonatomic) FHKContactResultsViewController *resultsController;
@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) NSArray *contacts;

@end
