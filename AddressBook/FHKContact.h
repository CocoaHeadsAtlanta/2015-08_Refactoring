//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

@import Foundation;

@interface FHKContact : NSObject

@property (strong, nonatomic, readonly) NSString *uniqueIdentifier;

@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *companyName;

@property (strong, nonatomic, readonly) NSString *email;
@property (strong, nonatomic, readonly) NSString *phoneNumber;

- (id)initWithPropertyList:(NSDictionary *)propertyList;
- (void)updateWithPropertyList:(NSDictionary *)propertyList;

@end

@interface FHKContact (CellSupport)

@property (strong, nonatomic, readonly) NSString *localizedDisplayName;

@end
