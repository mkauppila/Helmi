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
        [self navigateForward];
    }];

    self.logInButton.rac_command = [self.loginViewModel logInCommand];
}

- (void)navigateForward
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HELLoanViewController *loanVC = [storyboard instantiateViewControllerWithIdentifier:@"LoanTableViewControllerID"];
    [loanVC setCurrentUser:[self.loginViewModel currentUser]];

    UINavigationController *contentNavigationVC = [[UINavigationController alloc] initWithRootViewController:loanVC];
    contentNavigationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController presentViewController:contentNavigationVC
                                            animated:YES
                                          completion:NULL];
}

@end
