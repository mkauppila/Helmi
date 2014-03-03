//
//  LoanTableViewController.h
//  Helmi
//
//  Created by markus on 24.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface LoanViewController : UITableViewController
@property (strong, nonatomic) User *currentUser;
@end
