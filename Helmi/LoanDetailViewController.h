//
//  LoanDetailViewController.h
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoanableItem;

@interface LoanDetailViewController : UIViewController
@property (nonatomic, strong) LoanableItem *loanableItem;
@end
