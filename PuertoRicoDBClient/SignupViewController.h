//
//  SignupViewController.h
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupViewControllerDelegate;

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <SignupViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)signupAction:(id)sender;

@end

@protocol SignupViewControllerDelegate <NSObject>

- (void)signupViewControllerDidFinish:(SignupViewController *)controller;

@end
