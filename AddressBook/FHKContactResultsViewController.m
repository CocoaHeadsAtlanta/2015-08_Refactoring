//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactResultsViewController.h"
#import "FHKContact.h"

@implementation FHKContactResultsViewController

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.filteredContacts.count;
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
    
    FHKContact *contact = self.filteredContacts[indexPath.row];
    
    NSString *string = @"";
    
    if (contact.isCompany) {
        string = contact.companyName;
    }
    else {
        if (contact.firstName) {
            string = [string stringByAppendingString:contact.firstName];
        }
        if (contact.lastName) {
            if (string.length > 0) {
                string = [string stringByAppendingString:@" "];
            }
            
            string = [string stringByAppendingString:contact.lastName];
        }
    }
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutableAttributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:[string rangeOfString:self.searchTerm]];
    
    cell.textLabel.attributedText = [mutableAttributedString copy];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tappedOnContact:self.filteredContacts[indexPath.row]];
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
