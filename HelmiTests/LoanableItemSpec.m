//
//  LoanableItemSpec.m
//  Helmi
//
//  Created by markus on 4.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Kiwi.h>

#import "SpecHelper.h"

#import "LoanableItem.h"

SPEC_BEGIN(LoanableItemSpec)

describe(@"Loanble item", ^{
    __block LoanableItem *item = nil;
    
    beforeEach(^{
        item = [[LoanableItem alloc] initWithIdentifier:@"123456"];
        NSDictionary *itemInfo = LoadTestData(@"item");

        [item loadInformationFrom:itemInfo];
    });
    
    afterEach(^{
        item = nil;
    });
    
    it(@"it needs to have identifier", ^{
        [[[item identifier] should] beNonNil];
    });
    
    it(@"is due to March, 26th 2014", ^{
        NSCalendarUnit dateComponents =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *components = [[NSCalendar currentCalendar] components:dateComponents
                                                                       fromDate:[item dueDate]];
        [[theValue([components day]) should] equal:theValue(26)];
        [[theValue([components month]) should] equal:theValue(3)];
        [[theValue([components year]) should] equal:theValue(2014)];
    });
    
    it(@"is authored by Frank Herbert", ^{
        [[[item authorFirstName] should] equal:@"Frank"];
        [[[item authorFirstName] should] equal:@"Herbert"];
    });
    
    it(@"has title 'Dune Messiah'", ^{
        [[[item title] should] equal:@"Dune Messiah"];
    });
    
    it(@"it has circulation status of charged", ^{
        [[[item circulationStatus] should] equal:@"charged"];
    });
    
    // This doesn't worry about the due date, since overdue status is
    // retrieved by from circulation status. Thus this doesn't make the
    // test flaky
    it(@"is not overdue yet", ^{
        [[theValue([item isOverdue]) should] beFalse];
    });
});

SPEC_END
