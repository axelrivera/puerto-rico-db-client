//
//  FirstViewController.m
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import "ExploreViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface ExploreViewController ()

@end

@implementation ExploreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"Explore";
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																						  target:self
																						  action:@selector(showLocationAction:)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map"
																			  style:UIBarButtonItemStyleBordered
																			 target:self
																			 action:@selector(showMapAction:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Selector Methods

- (void)showLocationAction:(id)sender
{
	LocationViewController *locationController = [[LocationViewController alloc] initWithNibName:@"LocationViewController"
																						  bundle:nil];
	locationController.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:locationController];
	[self presentModalViewController:navController animated:YES];
}
	
- (void)showMapAction:(id)sender
{
	UIViewController *mapController = [[UIViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	[self.navigationController pushViewController:mapController animated:YES];
}

#pragma mark - UIViewController Delegates

- (void)locationViewControllerDidFinish:(LocationViewController *)controller
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
