//
//  AppDelegate.m
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "RLUserManager.h"
#import "ExploreViewController.h"
#import "ProfileViewController.h"
#import "LoginViewController.h"

@implementation AppDelegate

@synthesize window = window_;
@synthesize tabBarController = tabBarController_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[Parse setApplicationId:@"3eOmZ1mWgDayndD29mPyuH4wNEVYkws9XEhJps71" 
				  clientKey:@"w7Lt6nBl0RdFTWuD9Cm41bxWhamDCmERGOq9uZVY"];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userLoggedOut:)
												 name:RLUserManagerDidLogOutNotification
											   object:nil];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	
	UIViewController *exploreController = [[ExploreViewController alloc] initWithNibName:@"ExploreViewController" bundle:nil];
	UINavigationController *viewController1 = [[UINavigationController alloc] initWithRootViewController:exploreController];
	
	UIViewController *profileController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil]; 
	UINavigationController *viewController2 = [[UINavigationController alloc] initWithRootViewController:profileController];
	
	self.tabBarController = [[UITabBarController alloc] init];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
	self.window.rootViewController = self.tabBarController;
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[self showLoginScreenIfNecessaryAnimated:NO];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

- (void)userLoggedOut:(NSNotification *)notification
{
	[self showLoginScreenIfNecessaryAnimated:YES];
}

- (void)showLoginScreenIfNecessaryAnimated:(BOOL)animated
{
	NSLog(@"Checking for Login Screen");
	if ([RLUserManager currentUser] == nil) {
		LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
		[self.window.rootViewController presentModalViewController:navController animated:animated];
	}
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:RLUserManagerDidLogOutNotification object:nil];
}

@end
