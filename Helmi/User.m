//
//  User.m
//  Helmi
//
//  Created by markus on 23.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        _personalName = userInfo[@"personal name"];
        _emailAddress = userInfo[@"e-mail address"];
        
        NSDictionary *allItems = userInfo[@"items"];
        _loans = allItems[@"charged items"];
        _overdueLoans = allItems[@"overdue items"];
        
        _loansCount = [_loans count];
        _overdueLoansCount = [_overdueLoans count];
    }
    return self;
}

@end
