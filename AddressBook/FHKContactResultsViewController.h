//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHKContact.h"

@protocol FHKContactResultsViewControllerDelegate;

@interface FHKContactResultsViewController : UITableViewController <UISearchResultsUpdating>

@property (strong, nonatomic) NSArray *contacts;
@property (strong, nonatomic) NSArray *filteredContacts;
@property (strong, nonatomic) NSString *searchTerm;
@property (weak, nonatomic) id<FHKContactResultsViewControllerDelegate> delegate;

@end

@protocol FHKContactResultsViewControllerDelegate <NSObject>

- (void)tappedOnContact:(FHKContact *)contact;

@end
