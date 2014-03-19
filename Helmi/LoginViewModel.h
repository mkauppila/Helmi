//
//  LoginViewModel.h
//  Helmi
//
//  Created by markus on 12.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class RACCommand;

@class HELApiClient;
@class User;

@interface LoginViewModel : NSObject

@property (strong, nonatomic) NSString *libraryCardNumber;
@property (strong, nonatomic) NSString *pinCode;

@property (assign, nonatomic) BOOL didSucceedToLogin;
@property (strong, nonatomic) NSString *loginErrorMessage;

@property (strong, nonatomic) User *currentUser;

- (instancetype)initWithAPIClient:(HELApiClient *)apiClient;

- (void)initializeForLogin;

- (RACCommand *)logInCommand;

- (RACSignal *)initiateLogIn;

@end
