//
//  ViewController.m
//  Helmi
//
//  Created by markus on 8.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoginViewController.h"

#import <ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "LoginViewModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (strong, nonatomic) LoginViewModel *loginViewModel;
@end

@implementation LoginViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _loginViewModel = [LoginViewModel new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self bindWithViewModel];
}

- (void)bindWithViewModel
{
    RAC(self.loginViewModel, libraryCardNumber) = self.cardNumberTextField.rac_textSignal;
    RAC(self.loginViewModel, pinCode) = self.pinCodeTextField.rac_textSignal;
    
    [[[RACObserve(self.loginViewModel, didSucceedToLogin) distinctUntilChanged]
      filter:^BOOL(NSNumber *didSucceedToLogin) {
        return [didSucceedToLogin boolValue];
    }] subscribeNext:^(id x) {
        NSLog(@"-- go on, user did log in!");
    }];
    
    self.logInButton.rac_command = [self.loginViewModel logInCommand];;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
