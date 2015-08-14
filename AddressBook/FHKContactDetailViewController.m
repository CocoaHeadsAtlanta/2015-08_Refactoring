//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContactDetailViewController.h"
#import "FHKContact.h"

@implementation FHKContactDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *contactLocation = [[NSBundle mainBundle] URLForResource:self.contact.uniqueIdentifier withExtension:@"plist"];
    NSData *contactData = [NSData dataWithContentsOfURL:contactLocation];
    NSDictionary *contact = [NSPropertyListSerialization propertyListWithData:contactData
                                                                      options:NSPropertyListImmutable
                                                                       format:NULL
                                                                        error:NULL];
    
    self.contact.email = contact[@"email"];
    self.contact.phoneNumber = contact[@"phoneNumber"];
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
                cell = [tableView dequeueReusableCellWithIdentifier:@"First Name Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.firstName;
            }
            else if (self.contact.lastName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Last Name Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.lastName;
            }
            else if (self.contact.companyName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Company Name Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.companyName;
            }
        }
        else if (indexPath.row == 1) {
            if (self.contact.firstName != nil && self.contact.lastName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Last Name Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.lastName;
            }
            else if (self.contact.companyName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Company Name Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.companyName;
            }
        }
        else if (indexPath.row == 2) {
            if (self.contact.companyName != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Company Name Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.companyName;
            }
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.contact.email != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Email Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.email;
            }
            else if (self.contact.phoneNumber != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Phone Number Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.phoneNumber;
            }
        }
        else if (indexPath.row == 1) {
            if (self.contact.phoneNumber != nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Phone Number Cell" forIndexPath:indexPath];
                cell.textLabel.text = self.contact.phoneNumber;
            }
        }
    }
    
    return cell;
}

@end
