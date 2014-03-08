//
//  LoanDetailViewModel.h
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoanableItem;

@class RACCommand;

@interface LoanDetailViewModel : NSObject
@property (nonatomic, strong) LoanableItem *item;

- (RACCommand *)renewItemCommand;
@end
