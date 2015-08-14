//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContact.h"

@interface FHKContact ()

@property (assign, nonatomic, readonly, getter = isCompany) BOOL company;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phoneNumber;

@end

static NSString * const FHKContactKeyForIdentifier = @"uniqueIdentifier";
static NSString * const FHKContactKeyForFirstName = @"firstName";
static NSString * const FHKContactKeyForLastName = @"lastName";
static NSString * const FHKContactKeyForCompanyName = @"companyName";
static NSString * const FHKContactKeyForIsCompanyBool = @"company";
static NSString * const FHKContactKeyForEmail = @"email";
static NSString * const FHKContactKeyForPhoneNumber = @"phoneNumber";

@implementation FHKContact

- (id)initWithPropertyList:(NSDictionary *)propertyList
{
    self = [super init];
    if (self) {
        _uniqueIdentifier = propertyList[FHKContactKeyForIdentifier];
        _firstName = propertyList[FHKContactKeyForFirstName];
        _lastName = propertyList[FHKContactKeyForLastName];
        _companyName = propertyList[FHKContactKeyForCompanyName];
        _company = [propertyList[FHKContactKeyForIsCompanyBool] boolValue];
    }
    
    return self;
}

- (void)updateWithPropertyList:(NSDictionary *)propertyList
{
    self.email = propertyList[FHKContactKeyForEmail];
    self.phoneNumber = propertyList[FHKContactKeyForPhoneNumber];
}

@end

@implementation FHKContact (CellSupport)

- (NSString *)localizedDisplayName
{
    NSMutableString *localizedDisplayName = [NSMutableString stringWithString:@""];
    
    if (self.isCompany) {
        [localizedDisplayName appendString:self.companyName];
    }
    else {
        if (self.firstName) {
            [localizedDisplayName appendString:self.firstName];
        }
        if (self.lastName) {
            if (localizedDisplayName.length > 0) {
                [localizedDisplayName appendString:@" "];
            }
            
            [localizedDisplayName appendString:self.lastName];
        }
    }
    
    return [localizedDisplayName copy];
}

@end
