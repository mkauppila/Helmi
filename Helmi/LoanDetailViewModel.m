//
//  LoanDetailViewModel.m
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanDetailViewModel.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "LoanableItem.h"

@implementation LoanDetailViewModel

- (RACCommand *)renewItemCommand
{
    RACCommand *renewItem = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self renewItem];
    }];
    
    return renewItem;
}

- (RACSignal *)renewItem
{
    return [RACSignal empty];
}

@end
