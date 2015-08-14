//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactDetailViewController.h"
#import "FHKContact.h"

static NSString * const FHKFirstNameCellIdentifier = @"First Name Cell";
static NSString * const FHKLastNameCellIdentifier = @"Last Name Cell";
static NSString * const FHKCompanyNameCellIdentifier = @"Company Name Cell";
static NSString * const FHKEmailCellIdentifier = @"Email Cell";
static NSString * const FHKPhoneCellIdentifier = @"Phone Number Cell";

@implementation FHKContactDetailViewController

+ (NSString *)storyboardIdentifier
{
    return @"Contact Details";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *contactLocation = [[NSBundle mainBundle] URLForResource:self.contact.uniqueIdentifier withExtension:@"plist"];
    NSData *contactData = [NSData dataWithContentsOfURL:contactLocation];
    NSDictionary *contact = [NSPropertyListSerialization propertyListWithData:contactData
                                                                      options:NSPropertyListImmutable
                                                                       format:NULL
                                                                        error:NULL];
    
    [self.contact updateWithPropertyList:contact];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    
    switch (section) {
        case 0:
            if (self.contact.firstName != nil) {
                ++rowCount;
            }
            if (self.contact.lastName != nil) {
                ++rowCount;
            }
            if (self.contact.companyName != nil) {
                ++rowCount;
            }
            break;
        case 1:
            if (self.contact.email != nil) {
                ++rowCount;
            }
            if (self.contact.phoneNumber != nil) {
                ++rowCount;
            }
            break;
        default:
            return 0;
            break;
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.contact.firstName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKFirstNameCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.firstName;
            }
            else if (self.contact.lastName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKLastNameCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.lastName;
            }
            else if (self.contact.companyName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKCompanyNameCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.companyName;
            }
        }
        else if (indexPath.row == 1) {
            if (self.contact.firstName != nil && self.contact.lastName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKLastNameCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.lastName;
            }
            else if (self.contact.companyName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKCompanyNameCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.companyName;
            }
        }
        else if (indexPath.row == 2) {
            if (self.contact.companyName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKCompanyNameCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.companyName;
            }
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.contact.email != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKEmailCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.email;
            }
            else if (self.contact.phoneNumber != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKPhoneCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.phoneNumber;
            }
        }
        else if (indexPath.row == 1) {
            if (self.contact.phoneNumber != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:FHKPhoneCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = self.contact.phoneNumber;
            }
        }
    }
    
    return cell;
}

@end
