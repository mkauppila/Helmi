//
//  LoanDetailViewController.m
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELLoanDetailViewController.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "HELLoanDetailViewModel.h"
#import "HELLoanableItem.h"
#import "HELApiClient.h"

@interface HELLoanDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *renewButton;

@property (nonatomic, strong) HELLoanDetailViewModel *detailViewModel;
@end

@implementation HELLoanDetailViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _detailViewModel = [[HELLoanDetailViewModel alloc] initWithHelmetAPIClient:[HELApiClient sharedInstance]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpViewModel];
    [self bindWithViewModel];
}

- (void)setUpViewModel
{
    [self.detailViewModel setItem:self.loanableItem];
}

- (void)bindWithViewModel
{
    self.renewButton.rac_command = [self.detailViewModel renewItemCommand];
    RAC(self, title) = RACObserve(self.detailViewModel, item.title);
}

@end
