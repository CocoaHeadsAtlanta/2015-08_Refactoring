//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactsViewController.h"
#import "FHKContactResultsViewController.h"
#import "FHKContactResultsViewControllerDelegate.h"
#import "FHKContactDetailViewController.h"
#import "FHKContact.h"
#import "AddressBook-Swift.h"

@interface FHKContactsViewController () <FHKContactResultsViewControllerDelegate>

@property (strong, nonatomic) FHKContactResultsViewController *resultsController;
@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) ContactsDataSource *dataSource;

@end

static NSString * const FHKShowContactDetailSegue = @"Show Contact Detail";

@implementation FHKContactsViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSURL *addressBookLocation = [[NSBundle mainBundle] URLForResource:@"AddressBook" withExtension:@"plist"];
        NSData *addressBookData = [NSData dataWithContentsOfURL:addressBookLocation];
        NSArray *addressBookEntries = [NSPropertyListSerialization propertyListWithData:addressBookData
                                                                                options:NSPropertyListImmutable
                                                                                 format:NULL
                                                                                  error:NULL];
        
        NSArray *contacts = @[];
        for (NSDictionary *entry in addressBookEntries) {
            FHKContact *contact = [[FHKContact alloc] initWithPropertyList:entry];
            if (contact != nil) {
                contacts = [contacts arrayByAddingObject:contact];
            }
        }
        
        _dataSource = [[ContactsDataSource alloc] initWithContacts:contacts
                                                         configure:^(FHKContact *contact, UITableViewCell *cell) {
                                                             cell.textLabel.text = contact.localizedDisplayName;
                                                         }];
    }
    
    return self;
}

- (BOOL)definesPresentationContext
{
    return YES;
}

- (FHKContactResultsViewController *)resultsController
{
    if (!_resultsController) {
        FHKContactResultsViewController *results = [self.storyboard instantiateViewControllerWithIdentifier:FHKContactResultsViewController.storyboardIdentifier];
        results.delegate = self;
        
        self.resultsController = results;
    }
    
    return _resultsController;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];
        searchController.searchResultsUpdater = self.resultsController;
        [searchController.searchBar sizeToFit];
        
        self.searchController = searchController;
    }
    
    return _searchController;
}

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:FHKShowContactDetailSegue]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        FHKContactDetailViewController *detailVC = (FHKContactDetailViewController *)[segue.destinationViewController topViewController];
        detailVC.contact = [self.dataSource contactForIndexPath:indexPath];
    }
}

#pragma mark - Contact Results View Controller Delegate

- (void)resultsController:(FHKContactResultsViewController *)controller didSelectContact:(FHKContact *)contact
{
    FHKContactDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:FHKContactDetailViewController.storyboardIdentifier];
    detailVC.contact = contact;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    [self showDetailViewController:navVC sender:nil];
}

@end
