//
//  HelmiTests.m
//  HelmiTests
//
//  Created by markus on 8.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Kiwi.h>

#import "User.h"

NSDictionary *LoadTestData(NSString *fileName)
{
    NSString *pathToTestData = [[NSBundle bundleWithIdentifier:@"UnitTest"]
                                pathForResource:fileName ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:pathToTestData];
    return [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:kNilOptions
                                             error:NULL];
}

SPEC_BEGIN(UserSpec)

describe(@"User", ^{
    __block User *user = nil;
    
    beforeEach(^{
        NSDictionary *userInfo = LoadTestData(@"login");
        user = [[User alloc] initWithUserInfo:userInfo];
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

