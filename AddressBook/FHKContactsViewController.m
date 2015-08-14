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

@implementation FHKContactsViewController

- (BOOL)definesPresentationContext
{
    return YES;
}

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
    
    FHKContactResultsViewController *results = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact Results"];
    results.delegate = self;
    self.resultsController = results;
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:results];
    searchController.searchResultsUpdater = results;
    [searchController.searchBar sizeToFit];
    
    self.searchController = searchController;
    
    self.tableView.tableHeaderView = searchController.searchBar;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Contact Detail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        FHKContactDetailViewController *detailVC = (FHKContactDetailViewController *)[segue.destinationViewController topViewController];
        detailVC.contact = self.contacts[indexPath.row];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.contacts.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Contact Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Contact Cell"];
    }
    
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

- (void)tappedOnContact:(FHKContact *)contact
{
    FHKContactDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact Details"];
    detailVC.contact = contact;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    [self showDetailViewController:navVC sender:nil];
}

@end
