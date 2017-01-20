//
//  CaponeAppDelegate.h
//  Capone
//
//  Created by Alex Brown on 12/11/10.
//  Copyright 2010 Bad Guys Press. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CaponeViewController;

@interface CaponeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
	IBOutlet UIBarButtonItem *barButtonPlay, *barButtonPause;
	IBOutlet CaponeViewController *viewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButtonPlay, *barButtonPause;
@property (nonatomic, retain) IBOutlet CaponeViewController *viewController;

@end

