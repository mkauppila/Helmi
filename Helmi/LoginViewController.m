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
    
    @weakify(self);
    
    RACSignal *enableLogInButtonSignal = [RACSignal
                                          combineLatest:@[self.cardNumberTextField.rac_textSignal,
                                                          self.pinCodeTextField.rac_textSignal]
                                          reduce:^(NSString *cardNumber, NSString *pinCode) {
                                              return @(cardNumber.length > 0 && pinCode.length >= 4);
                                          }];
    
    RACCommand *logInCommand = [[RACCommand alloc]
                                initWithEnabled:enableLogInButtonSignal
                                signalBlock:^RACSignal *(id input) {
                                    @strongify(self);
                                    return [self.loginViewModel logInUsingCardNumber:self.cardNumberTextField.text
                                                                          andPinCode:self.pinCodeTextField.text];
                                }];
    
    [logInCommand.executionSignals subscribeNext:^(RACSignal *loginSignal) {
        [loginSignal subscribeNext:^(NSString *message) {
            NSLog(@"log in signal next");
            NSLog(@"- message: %@", message);
        }];
    }];
    
    self.logInButton.rac_command = logInCommand;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
