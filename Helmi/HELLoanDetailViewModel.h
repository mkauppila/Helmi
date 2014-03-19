//
//  LoanDetailViewModel.h
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HELLoanableItem;
@class HELApiClient;

@class RACCommand;

@interface HELLoanDetailViewModel : NSObject
@property (nonatomic, strong) HELLoanableItem *item;

- (instancetype)initWithHelmetAPIClient:(HELApiClient *)apiClient;

- (RACCommand *)renewItemCommand;
@end
