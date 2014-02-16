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
    return login;
}

- (RACSignal *)initiateLogIn
{
    RACReplaySubject *result = [RACReplaySubject subject];
    
    [result sendNext:@"Okay, log in happend"];
    [result sendCompleted];
    
    return result;
}

@end
