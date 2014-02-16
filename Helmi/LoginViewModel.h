//
//  LoginViewModel.h
//  Helmi
//
//  Created by markus on 12.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface LoginViewModel : NSObject

@property (strong, nonatomic) NSString *libraryCardNumber;
@property (strong, nonatomic) NSString *pinCode;

- (RACSignal *)logInUsingCardNumber:(NSString *)cardNumber andPinCode:(NSString *)pinCode;

@end
