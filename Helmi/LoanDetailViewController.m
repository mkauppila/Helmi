//
//  LoanDetailViewController.m
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanDetailViewController.h"

#import "LoanableItem.h"

@interface LoanDetailViewController ()
@end

@implementation LoanDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.loanableItem title];
}

@end
