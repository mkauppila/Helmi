//
//  HelmetAPIClient.h
//  Helmi
//
//  Created by markus on 21.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@class LoanableItem;

@interface HelmetAPIClient : NSObject

+ (instancetype)sharedInstance;

- (RACSignal *)executeLogIn:(NSString *)libraryCardNumber pinCode:(NSString *)pinCode;

- (RACSignal *)fetchInformationForLoanableItem:(LoanableItem *)item;

- (RACSignal *)renewLoan:(LoanableItem *)item;

@end
