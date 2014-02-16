//
//  LoginViewModel.m
//  Helmi
//
//  Created by markus on 12.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoginViewModel.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>
#import <AFHTTPRequestOperationManager+RACSupport.h>

@implementation LoginViewModel

- (RACCommand *)logInCommand
{
    @weakify(self);
    
    RACSignal *enabled = [RACSignal combineLatest:@[RACObserve(self, libraryCardNumber),
                                                    RACObserve(self, pinCode)]
                                           reduce:^(NSString *cardNumber, NSString *pinCode) {
                                               return @(cardNumber.length > 0 && pinCode.length >= 4);
                                           }];
    RACCommand *login = [[RACCommand alloc] initWithEnabled:enabled
                                                signalBlock:^RACSignal *(id input) {
                                                    @strongify(self);
                                                    return [self initiateLogIn];
                                                }];
    login.allowsConcurrentExecution = NO;
    return login;
}

- (RACSignal *)initiateLogIn
{
    NSLog(@"library card number: %@", self.libraryCardNumber);
    NSLog(@"pin code: %@", self.pinCode);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];

    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [[manager requestSerializer] setAuthorizationHeaderFieldWithUsername:self.libraryCardNumber password:self.pinCode];
    
    NSString *urlString = [NSString stringWithFormat:@"https://lainakortti.helmet-kirjasto.fi/patron/%@", self.libraryCardNumber];
    RACSignal *s = [[[manager rac_GET:urlString parameters:nil] logAll] replayLazily];
    
    @weakify(self);
    [s subscribeNext:^(RACTuple *response) {
        @strongify(self);
        NSLog(@"first: %@", response.first);
        NSLog(@"second: %@", response.second);
        
        self.didSucceedToLogin = YES;
    } error:^(NSError *error) {
        NSLog(@"network error: %@", error);
    }];
    
    return s;
}

@end
