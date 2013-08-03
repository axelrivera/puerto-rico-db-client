//
//  LoginViewController.m
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@implementation LoginViewController

@synthesize usernameField = usernameField_;
@synthesize passwordField = passwordField_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Login";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Signup"
																			  style:UIBarButtonItemStyleBordered
																			 target:self
																			 action:@selector(signupAction:)];
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

- (IBAction)loginAction:(id)sender
{
	[[RLUserManager sharedManager] loginWithUsername:self.usernameField.text
										 andPassword:self.passwordField.text
											delegate:self];
}

- (IBAction)passwordAction:(id)sender
{
	
}

- (void)signupAction:(id)sender
{
	SignupViewController *signupController = [[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];
	signupController.delegate = self;
	[self.navigationController pushViewController:signupController animated:YES];
}

#pragma mark - UIViewController Delegate Methods

- (void)signupViewControllerDidFinish:(SignupViewController *)controller
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - RLUserManager Delegate Methods

- (void)userDidLogin:(PFUser *)user
{
	NSLog(@"Login: %@", user);
	[self dismissModalViewControllerAnimated:YES];
}

- (void)user:(PFUser *)user didFailLoginWithError:(NSError *)error
{
	NSLog(@"%@", error);
}

@end
