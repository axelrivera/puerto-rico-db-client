//
//  RLUser.h
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 4/20/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol RLUserManagerDelegate;

@interface RLUserManager : NSObject

@property (weak, nonatomic) id<RLUserManagerDelegate> delegate;

+ (RLUserManager *)sharedManager;
+ (PFUser *)currentUser;

- (void)signUpUser:(PFUser *)user withDelegate:(id<RLUserManagerDelegate>)delegate;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password delegate:(id<RLUserManagerDelegate>)delegate;
- (BOOL)isLoggedIn;
- (void)logOut;

@end

extern NSString* const RLUserManagerDidLoginNotification; // Posted when the User logs in
extern NSString* const RLUserManagerDidLogOutNotification; // Posted when the User logs out

@protocol RLUserManagerDelegate <NSObject>

@optional

- (void)userDidSignUp:(PFUser *)user;
- (void)user:(PFUser *)user didFailSignUpWithError:(NSError *)error;

- (void)userDidLogin:(PFUser *)user;
- (void)user:(PFUser *)user didFailLoginWithError:(NSError *)error;
- (void)userDidLogOut:(PFUser *)user;

@end