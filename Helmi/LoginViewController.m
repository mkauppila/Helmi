//
//  ViewController.m
//  Helmi
//
//  Created by markus on 8.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import "LoginViewController.h"

#import <ReactiveCocoa.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RACSignal *enableLogInButtonSignal = [RACSignal
                                          combineLatest:@[self.cardNumberTextField.rac_textSignal,
                                                          self.pinCodeTextField.rac_textSignal]
                                          reduce:^(NSString *cardNumber, NSString *pinCode) {
                                              return @(cardNumber.length > 0 && pinCode.length >= 4);
                                          }];
    
    RACCommand *logInCommand = [[RACCommand alloc]
                                initWithEnabled:enableLogInButtonSignal
                                signalBlock:^RACSignal *(id input) {
                                    NSLog(@"log in button pressed");
                                    return [RACSignal empty];
                                }];
    
    self.logInButton.rac_command = logInCommand;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
