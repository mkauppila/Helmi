//
//  LoanTableViewController.m
//  Helmi
//
//  Created by markus on 24.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanViewController.h"

#import "LoanViewModel.h"

@interface LoanViewController ()
@property (strong, nonatomic) LoanViewModel *loanViewModel;
@end

@implementation LoanViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _loanViewModel = [LoanViewModel new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
