//
//  RLUser.m
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 4/20/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import "RLUserManager.h"

static RLUserManager *sharedManager_ = nil;

// Constants
static NSString* const kRLUserManagerCurrentUserIDDefaultsKey = @"RLUserManagerCurrentUserIDDefaultsKey";

// Notifications
NSString * const RLUserManagerDidLoginNotification = @"RLUserDidLoginNotification";
NSString * const RLUserManagerDidFailLoginNotification = @"RLUserDidFailLoginNotification";
NSString * const RLUserManagerDidLogOutNotification = @"RLUserDidLogOutNotification";

@interface RLUserManager (Private)

- (void)loginWasSuccessful;

@end

@implementation RLUserManager

@synthesize delegate = delegate_;

+ (PFUser *)currentUser
{
	return [PFUser currentUser];
}

- (void)signUpUser:(PFUser *)user withDelegate:(id<RLUserManagerDelegate>)delegate
{
	self.delegate = delegate;
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (!error) {
			if ([self.delegate respondsToSelector:@selector(userDidSignUp:)]) {
				[self.delegate userDidSignUp:user];
			}
			
			[self loginWasSuccessful];
		} else {
			if ([self.delegate respondsToSelector:@selector(user:didFailSignUpWithError:)]) {
				[self.delegate user:user didFailSignUpWithError:error];
			}
		}
    }];
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password delegate:(id<RLUserManagerDelegate>)delegate
{
	self.delegate = delegate;
	[PFUser logInWithUsernameInBackground:username password:password 
									block:^(PFUser *user, NSError *error)
	 {
		 if (user) {
			 [self loginWasSuccessful];
		 } else {
			 if ([self.delegate respondsToSelector:@selector(user:didFailLoginWithError:)]) {
				 [self.delegate user:user didFailLoginWithError:error];
			 }
		 }
	 }];
}

- (BOOL)isLoggedIn
{
	return ([PFUser currentUser] == nil) ? NO : YES;
}

- (void)logOut
{
	PFUser *user = [PFUser currentUser];
	
	[PFUser logOut];
	
	[[NSUserDefaults standardUserDefaults] setValue:nil forKey:kRLUserManagerCurrentUserIDDefaultsKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	if ([self.delegate respondsToSelector:@selector(userDidLogOut:)]) {
		[self.delegate userDidLogOut:user];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:RLUserManagerDidLogOutNotification object:user];
}

#pragma mark - Private Methods

- (void)loginWasSuccessful
{
	[[NSUserDefaults standardUserDefaults] setObject:[[PFUser currentUser] username] forKey:kRLUserManagerCurrentUserIDDefaultsKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	if ([self.delegate respondsToSelector:@selector(userDidLogin:)]) {
		[self.delegate userDidLogin:[PFUser currentUser]];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:RLUserManagerDidLoginNotification object:[PFUser currentUser]];
}

#pragma mark - Singleton Code

+ (RLUserManager *)sharedManager
{
    if (sharedManager_ == nil) {
        sharedManager_ = [[super allocWithZone:NULL] init];
    }
    return sharedManager_;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self class] sharedManager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
