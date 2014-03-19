//
//  HelmetAPIClient.h
//  Helmi
//
//  Created by markus on 21.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@class HELLoanableItem;

@interface HELApiClient : NSObject

+ (instancetype)sharedInstance;

- (RACSignal *)executeLogIn:(NSString *)libraryCardNumber pinCode:(NSString *)pinCode;

- (RACSignal *)fetchInformationForLoanableItem:(HELLoanableItem *)item;

- (RACSignal *)renewLoan:(HELLoanableItem *)item;

@end
