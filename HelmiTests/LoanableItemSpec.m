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
    });
    
    afterEach(^{
        item = nil;
    });
    
    it(@"it needs to have identifier", ^{
        [[[item identifier] should] beNonNil];
    });
});

SPEC_END
