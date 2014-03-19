//
//  HelmiTests.m
//  HelmiTests
//
//  Created by markus on 8.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Kiwi.h>

#import "SpecHelper.h"

#import "HELUser.h"
#import "HELLoanableItem.h"

SPEC_BEGIN(UserSpec)

describe(@"User", ^{
    __block HELUser *user = nil;
    
    beforeEach(^{
        NSDictionary *userInfo = LoadTestData(@"login");
        HELLoanableItem *item = [[HELLoanableItem alloc] initWithIdentifier:@"aa"];
        user = [[HELUser alloc] initWithUserInfo:userInfo andLoanableItems:@[item]];
    });
    
    afterEach(^{
        user = nil;
    });
    
    it(@"has correct email address", ^{
        [[[user emailAddress] should] equal:@"hello@example.com"];
    });
    
    it(@"has a personal name", ^{
        [[[user personalName] should] equal:@"Korhonen, Teppo Tapani"];
    });
});

SPEC_END

