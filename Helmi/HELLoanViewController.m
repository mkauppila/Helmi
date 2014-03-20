//
// Copyright (c) 2014 Markus Kauppila <markus.kauppila@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
