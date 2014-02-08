//
//  ViewController.h
//  Helmi
//
//  Created by markus on 8.2.2014.
//  Copyright (c) 2014 Markus Kauppila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@end
