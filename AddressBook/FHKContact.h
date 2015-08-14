//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

@import Foundation;

@interface FHKContact : NSObject

@property (strong, nonatomic, readonly) NSString *uniqueIdentifier;

@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *companyName;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phoneNumber;

- (id)initWithPropertyList:(NSDictionary *)propertyList;

@end

extern NSString * const FHKContactKeyForEmail;
extern NSString * const FHKContactKeyForPhoneNumber;

@interface FHKContact (CellSupport)

@property (strong, nonatomic, readonly) NSString *localizedDisplayName;

@end
