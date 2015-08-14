//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactsViewController.h"
#import "FHKContactResultsViewController.h"
#import "FHKContactResultsViewControllerDelegate.h"
#import "FHKContactDetailViewController.h"
#import "FHKContact.h"

@interface FHKContactsViewController () <FHKContactResultsViewControllerDelegate>

@property (strong, nonatomic) FHKContactResultsViewController *resultsController;
@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) NSArray *contacts;

@end

static NSString * const FHKContactCellIdentifier = @"Contact Cell";
static NSString * const FHKShowContactDetailSegue = @"Show Contact Detail";

@implementation FHKContactsViewController

- (BOOL)definesPresentationContext
{
    return YES;
}

- (FHKContactResultsViewController *)resultsController
{
    if (!_resultsController) {
        FHKContactResultsViewController *results = [self.storyboard instantiateViewControllerWithIdentifier:FHKContactResultsViewController.storyboardIdentifier];
        results.delegate = self;
        results.cellIdentifier = FHKContactCellIdentifier;
        
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
    
    self.contacts = contacts;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:FHKShowContactDetailSegue]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        FHKContactDetailViewController *detailVC = (FHKContactDetailViewController *)[segue.destinationViewController topViewController];
        detailVC.contact = self.contacts[indexPath.row];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSAssert(section == 0, @"Unexpected section number: %li", (long)section);
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FHKContactCellIdentifier
                                                            forIndexPath:indexPath];
    
    FHKContact *contact = self.contacts[indexPath.row];
    
    if (contact.isCompany) {
        cell.textLabel.text = contact.companyName;
    }
    else {
        NSString *fullName = @"";
        if (contact.firstName) {
            fullName = [fullName stringByAppendingString:contact.firstName];
        }
        if (contact.lastName) {
            if (fullName.length > 0) {
                fullName = [fullName stringByAppendingString:@" "];
            }
            
            fullName = [fullName stringByAppendingString:contact.lastName];
        }
        
        cell.textLabel.text = fullName;
    }
    
    return cell;
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
