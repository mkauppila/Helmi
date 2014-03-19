//
//  ViewController.m
//  Helmi
//
//  Created by markus on 8.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "HELLoginViewController.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "HELLoanViewController.h"

#import "HELLoginViewModel.h"
#import "HELApiClient.h"

@interface HELLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UILabel *loginErrorLabel;

@property (strong, nonatomic) HELLoginViewModel *loginViewModel;
@end

@implementation HELLoginViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _loginViewModel = [[HELLoginViewModel alloc] initWithAPIClient:
                           [HELApiClient sharedInstance]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self bindWithViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.loginViewModel initializeForLogin];
}

- (void)bindWithViewModel
{
    RAC(self.loginViewModel, libraryCardNumber) = self.cardNumberTextField.rac_textSignal;
    RAC(self.loginViewModel, pinCode) = self.pinCodeTextField.rac_textSignal;
    
    RAC(self.loginErrorLabel, text) = RACObserve(self.loginViewModel, loginErrorMessage);
    
    @weakify(self);
    [[[RACObserve(self.loginViewModel, didSucceedToLogin) distinctUntilChanged]
      filter:^BOOL(NSNumber *didSucceedToLogin) {
        return [didSucceedToLogin boolValue];
    }] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HELLoanViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"LoanTableViewControllerID"];
        [controller setCurrentUser:[self.loginViewModel currentUser]];
        
        [self.navigationController pushViewController:controller
                                             animated:YES];
        
    }];

    self.logInButton.rac_command = [self.loginViewModel logInCommand];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
