//
//  LoanDetailViewController.m
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanDetailViewController.h"

#import "LoanDetailViewModel.h"
#import "LoanableItem.h"

@interface LoanDetailViewController ()
@property (nonatomic, strong) LoanDetailViewModel *detailViewModel;
@end

@implementation LoanDetailViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _detailViewModel = [LoanDetailViewModel new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.detailViewModel setItem:self.loanableItem];
    
    self.title = [self.loanableItem title];
}

@end
