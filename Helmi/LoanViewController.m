//
//  LoanTableViewController.m
//  Helmi
//
//  Created by markus on 24.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanViewController.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "LoanViewModel.h"
#import "LoanTableDataSource.h"
#import "LoanCell.h"

#import "LoanableItem.h"
#import "User.h"

@interface LoanViewController ()
@property (strong, nonatomic) LoanViewModel *loanViewModel;
@property (strong, nonatomic) LoanTableDataSource *tableDataSource;
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
    
    [self.loanViewModel setCurrentUser:self.currentUser];
    
    RAC(self, title) = RACObserve(self.loanViewModel, title);
    
    NSString *const reuseId = @"LoanCellReuseIdentifier";
    void (^cellConfigurator)(LoanCell *, LoanableItem *) = ^(LoanCell *cell, LoanableItem *item) {
        [cell setLoanableItem:item];
    };
    
    self.tableDataSource = [[LoanTableDataSource alloc] initWithItems:[self.currentUser loanableItems]
                                                      reuseIdentifier:reuseId
                                               cellConfigurationBlock:cellConfigurator];
    
    self.tableView.dataSource = self.tableDataSource;
}

@end
