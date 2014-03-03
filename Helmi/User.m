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
                andLoanableItems:(NSArray *)loanableItems
{
    self = [super init];
    if (self) {
        _personalName = userInfo[@"personal name"];
        _emailAddress = userInfo[@"e-mail address"];
        
        _loanableItems = loanableItems;
    }
    return self;
}

@end
