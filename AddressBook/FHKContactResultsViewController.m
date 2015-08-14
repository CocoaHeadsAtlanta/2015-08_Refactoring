//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactResultsViewController.h"
#import "FHKContactResultsViewControllerDelegate.h"
#import "FHKContact.h"
#import "AddressBook-Swift.h"

@interface FHKContactResultsViewController ()

@property (strong, nonatomic) NSArray *contacts;
@property (strong, nonatomic) NSArray *filteredContacts;
@property (strong, nonatomic) NSString *searchTerm;

@property (strong, nonatomic) ContactsDataSource *dataSource;

@end

@implementation FHKContactResultsViewController

+ (NSString *)storyboardIdentifier
{
    return @"Contact Results";
}

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
        
        _contacts = contacts;
        
        __weak typeof(self) weakSelf = self;
        _dataSource = [[ContactsDataSource alloc] initWithContacts:contacts
                                                         configure:^(FHKContact * contact, UITableViewCell * cell) {
                                                             __strong typeof(weakSelf) strongSelf = weakSelf;
                                                             if (strongSelf) {
                                                                 NSString *localizedDisplayName = contact.localizedDisplayName;
                                                                 NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:localizedDisplayName];
                                                                 [mutableAttributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:[localizedDisplayName rangeOfString:strongSelf.searchTerm]];
                                                                 cell.textLabel.attributedText = [mutableAttributedString copy];
                                                             }
                                                             else {
                                                                 cell.textLabel.text = contact.localizedDisplayName;
                                                             }
                                                         }];
    }
    
    return self;
}

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self.dataSource;
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
