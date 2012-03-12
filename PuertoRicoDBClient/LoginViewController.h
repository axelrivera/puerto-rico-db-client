//
//  LoginViewController.h
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, SignupViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginAction:(id)sender;
- (IBAction)passwordAction:(id)sender;

@end
