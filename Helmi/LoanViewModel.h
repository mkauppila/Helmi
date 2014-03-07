//
//  LoanViewModel.h
//  Helmi
//
//  Created by markus on 3.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface LoanViewModel : NSObject
@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) NSString *title;
@end
