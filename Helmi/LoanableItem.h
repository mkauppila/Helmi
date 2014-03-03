//
//  Loan.h
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanableItem : NSObject
@property (nonatomic, copy, readonly) NSString *identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier;
@end
