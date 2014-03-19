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

#import "HELApiClient.h"

@interface LoanDetailViewModel ()
@property (strong, nonatomic) HELApiClient *apiClient;
@end

@implementation LoanDetailViewModel

- (instancetype)initWithHelmetAPIClient:(HELApiClient *)apiClient
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
    }
    return self;
}

- (RACCommand *)renewItemCommand
{
    RACCommand *renewItem = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self renewItem];
    }];
    
    return renewItem;
}

- (RACSignal *)renewItem
{
    RACSignal *renewSignal = [self.apiClient renewLoan:self.item];
    
    [renewSignal subscribeNext:^(RACTuple *response) {
        NSDictionary *info = response.second;
        NSLog(@"Response: %@", info);
    } error:^(NSError *error) {
        NSLog(@"error happend: %@", error);
    }];
    
    return renewSignal;
}

@end
