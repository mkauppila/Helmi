//
//  LoginViewModel.m
//  Helmi
//
//  Created by markus on 12.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoginViewModel.h"

#import <ReactiveCocoa.h>

@implementation LoginViewModel

- (RACSignal *)logInUsingCardNumber:(NSString *)cardNumber andPinCode:(NSString *)pinCode
{
    RACReplaySubject *result = [RACReplaySubject subject];
    
    [result sendNext:@"Okay, log in happend"];
    [result sendCompleted];
    
    return result;
}

@end
