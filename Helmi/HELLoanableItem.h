//
//  Loan.h
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HELLoanableItem : NSObject
@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *circulationStatus;
@property (nonatomic, strong, readonly) NSDate *dueDate;

@property (nonatomic, copy, readonly) NSString *authorFirstName;
@property (nonatomic, copy, readonly) NSString *authorLastName;

@property (nonatomic, assign, readonly) BOOL isOverdue;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (void)loadInformationFrom:(NSDictionary *)itemInfo;
@end
