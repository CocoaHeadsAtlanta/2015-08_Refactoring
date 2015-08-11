//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHKContact : NSObject

@property (strong, nonatomic) NSString *uniqueIdentifier;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *companyName;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phoneNumber;

@property (assign, nonatomic, getter = isCompany) BOOL company;

- (id)initWithPropertyList:(NSDictionary *)propertyList;

@end
