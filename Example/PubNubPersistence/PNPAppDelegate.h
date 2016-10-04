//
//  PNPAppDelegate.h
//  PubNubPersistence
//
//  Created by Jordan Zucker on 07/07/2016.
//  Copyright (c) 2016 Jordan Zucker. All rights reserved.
//

@import UIKit;

@class PubNubPersistence;

@interface PNPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) PubNubPersistence *client;

@end
