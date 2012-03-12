//
//  SecondViewController.h
//  PuertoRicoDBClient
//
//  Created by Axel Rivera on 3/9/12.
//  Copyright (c) 2012 Axel Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationViewControllerDelegate;

@interface LocationViewController : UIViewController

@property (weak, nonatomic) id <LocationViewControllerDelegate> delegate;

@end

@protocol LocationViewControllerDelegate <NSObject>

- (void)locationViewControllerDidFinish:(LocationViewController *)controller;

@end
