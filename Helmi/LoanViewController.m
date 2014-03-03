//
//  LoanTableViewController.m
//  Helmi
//
//  Created by markus on 24.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanViewController.h"

#import "LoanViewModel.h"
#import "LoanTableDataSource.h"

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
    
    NSArray *items = @[@"aa", @"bb", @"cc"];
    NSString *const reuseId = @"LoanCellReuseIdentifier";
    void (^cellConfigurator)(id, id) = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };
    
    self.tableDataSource = [[LoanTableDataSource alloc] initWithItems:items
                                                      reuseIdentifier:reuseId
                                               cellConfigurationBlock:cellConfigurator];
    
    self.tableView.dataSource = self.tableDataSource;
}

@end
