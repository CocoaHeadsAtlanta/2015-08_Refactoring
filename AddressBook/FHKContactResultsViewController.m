//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactResultsViewController.h"
#import "FHKContactResultsViewControllerDelegate.h"
#import "FHKContact.h"

@interface FHKContactResultsViewController ()

@property (strong, nonatomic) NSArray *contacts;
@property (strong, nonatomic) NSArray *filteredContacts;
@property (strong, nonatomic) NSString *searchTerm;

@end

@implementation FHKContactResultsViewController

+ (NSString *)storyboardIdentifier
{
    return @"Contact Results";
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
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSAssert(section == 0, @"Unexpected section number: %li", (long)section);
    return self.filteredContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    
    FHKContact *contact = self.filteredContacts[indexPath.row];
    
    NSString *string = contact.localizedDisplayName;
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutableAttributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:[string rangeOfString:self.searchTerm]];
    
    cell.textLabel.attributedText = [mutableAttributedString copy];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate resultsController:self didSelectContact:self.filteredContacts[indexPath.row]];
}

#pragma mark - Search Controller Results Updater

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.searchTerm = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(firstName contains[cd] %@) OR (lastName contains[cd] %@) OR (companyName contains[cd] %@)", self.searchTerm, self.searchTerm, self.searchTerm];
    self.filteredContacts = [self.contacts filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}

@end
