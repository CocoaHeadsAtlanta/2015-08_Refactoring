//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContact.h"

static NSString * const FHKContactKeyForIdentifier = @"uniqueIdentifier";
static NSString * const FHKContactKeyForFirstName = @"firstName";
static NSString * const FHKContactKeyForLastName = @"lastName";
static NSString * const FHKContactKeyForCompanyName = @"companyName";
static NSString * const FHKContactKeyForIsCompanyBool = @"company";
NSString * const FHKContactKeyForEmail = @"email";
NSString * const FHKContactKeyForPhoneNumber = @"phoneNumber";

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

@end
