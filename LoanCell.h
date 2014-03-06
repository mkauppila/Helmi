//
//  LoanCell.h
//  Helmi
//
//  Created by markus on 6.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  RACDisposable;

@class  LoanableItem;

@interface LoanCell : UITableViewCell
@property (nonatomic, strong) RACDisposable *update;

- (void)setLoanableItem:(LoanableItem *)item;
@end
