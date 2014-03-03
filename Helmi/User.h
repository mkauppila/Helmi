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

//@property (assign, nonatomic, readonly) NSUInteger loansCount;
//@property (assign, nonatomic, readonly) NSUInteger overdueLoansCount;
@property (assign, nonatomic, readonly) NSUInteger itemsLimit;

@property (strong, nonatomic, readonly) NSArray *loanableItems;
/*
@property (strong, nonatomic, readonly) NSArray *loans;
@property (strong, nonatomic, readonly) NSArray *overdueLoans;
 */

// TODO add fee amount + fee limit

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo
                andLoanableItems:(NSArray *)loanableItems;

@end
