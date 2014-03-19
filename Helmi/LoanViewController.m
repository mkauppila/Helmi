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

#import "HELLoanDetailViewController.h"

#import "LoanViewModel.h"
#import "LoanTableDataSource.h"
#import "LoanCell.h"

#import "HELLoanableItem.h"
#import "HELUser.h"

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
    
    [self setUpViewModel];
    
    RAC(self, title) = RACObserve(self.loanViewModel, title);
    
    NSString *const reuseId = @"LoanCellReuseIdentifier";
    void (^cellConfigurator)(LoanCell *, HELLoanableItem *) = ^(LoanCell *cell, HELLoanableItem *item) {
        [cell setLoanableItem:item];
    };
    
    self.tableDataSource = [[LoanTableDataSource alloc] initWithItems:[self.currentUser loanableItems]
                                                      reuseIdentifier:reuseId
                                               cellConfigurationBlock:cellConfigurator];
    
    self.tableView.dataSource = self.tableDataSource;
}

- (void)setUpViewModel
{
    [self.loanViewModel setCurrentUser:self.currentUser];
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"OpenLoanSegue"]) {
        LoanCell *loanCell = (LoanCell *)sender;
        HELLoanDetailViewController *controller = (HELLoanDetailViewController *)[segue destinationViewController];
        [controller setLoanableItem:[loanCell loanableItem]];
    }
}

@end
