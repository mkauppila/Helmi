//
//  User.h
//  Helmi
//
//  Created by markus on 23.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
// full name in format "Pulkkinen, Matti Olli"
@property (strong, nonatomic, readonly) NSString *personalName;
@property (strong, nonatomic, readonly) NSString *emailAddress;

@property (assign, nonatomic, readonly) NSUInteger itemsLimit;

@property (strong, nonatomic, readonly) NSArray *loanableItems;

// TODO add fee amount + fee limit

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo
                andLoanableItems:(NSArray *)loanableItems;

@end
