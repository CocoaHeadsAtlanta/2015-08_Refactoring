//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

@class FHKContact;
@class FHKContactResultsViewController;

@protocol FHKContactResultsViewControllerDelegate <NSObject>

- (void)resultsController:(FHKContactResultsViewController *)controller didSelectContact:(FHKContact *)contact;

@end
