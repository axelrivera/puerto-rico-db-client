//
//  SignupViewController.m
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize delegate = delegate_;
@synthesize usernameField = usernameField_;
@synthesize passwordField = passwordField_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Signup";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Action Methods

- (IBAction)signupAction:(id)sender
{
	if (![self.usernameField.text isEqualToString:@""] && ![self.passwordField.text isEqualToString:@""]) {
		PFUser *user = [PFUser user];
		user.username = self.usernameField.text;
		user.password = self.passwordField.text;
		
		[user signUpInBackgroundWithBlock:^(BOOL succedded, NSError *error) {
			if (!error) {
				[self.delegate signupViewControllerDidFinish:self];
			} else {
				NSString *errorString = [[error userInfo] objectForKey:@"error"];
				NSLog(@"%@", errorString);
			}
		}];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self performSelector:@selector(signupAction:) withObject:textField];
	return YES;
}

@end
