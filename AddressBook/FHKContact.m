//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import "FHKContact.h"

@implementation FHKContact

- (id)initWithPropertyList:(NSDictionary *)propertyList
{
    self = [super init];
    if (self) {
        _uniqueIdentifier = propertyList[@"uniqueIdentifier"];
        _firstName = propertyList[@"firstName"];
        _lastName = propertyList[@"lastName"];
        _companyName = propertyList[@"companyName"];
        _company = [propertyList[@"company"] boolValue];
    }
    
    return self;
}

@end
