//
//  LoanTableViewController.m
//  Helmi
//
//  Created by markus on 24.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELLoanViewController.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "HELLoanDetailViewController.h"

#import "HELLoanViewModel.h"
#import "HELLoanTableDataSource.h"
#import "HELLoanCell.h"

#import "HELLoanableItem.h"
#import "HELUser.h"

@interface HELLoanViewController ()
@property (strong, nonatomic) HELLoanViewModel *loanViewModel;
@property (strong, nonatomic) HELLoanTableDataSource *tableDataSource;
@end

@implementation HELLoanViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _loanViewModel = [HELLoanViewModel new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpViewModel];
    
    RAC(self, title) = RACObserve(self.loanViewModel, title);
    
    NSString *const reuseId = @"LoanCellReuseIdentifier";
    void (^cellConfigurator)(HELLoanCell *, HELLoanableItem *) = ^(HELLoanCell *cell, HELLoanableItem *item) {
        [cell setLoanableItem:item];
    };
    
    self.tableDataSource = [[HELLoanTableDataSource alloc] initWithItems:[self.currentUser loanableItems]
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
        HELLoanCell *loanCell = (HELLoanCell *)sender;
        HELLoanDetailViewController *controller = (HELLoanDetailViewController *)[segue destinationViewController];
        [controller setLoanableItem:[loanCell loanableItem]];
    }
}

@end
