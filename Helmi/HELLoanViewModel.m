//
//  LoanViewModel.m
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELLoanViewModel.h"

@implementation HELLoanViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = NSLocalizedString(@"Lainat", nil);
    }
    return self;
}

@end
