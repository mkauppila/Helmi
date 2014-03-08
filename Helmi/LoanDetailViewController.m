//
//  LoanDetailViewController.m
//  Helmi
//
//  Created by markus on 8.3.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoanDetailViewController.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "LoanDetailViewModel.h"
#import "LoanableItem.h"

@interface LoanDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *renewButton;

@property (nonatomic, strong) LoanDetailViewModel *detailViewModel;
@end

@implementation LoanDetailViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _detailViewModel = [LoanDetailViewModel new];
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
