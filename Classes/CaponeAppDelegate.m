//
//  CaponeAppDelegate.m
//  Capone
//
//  Created by Alex Brown on 12/11/10.
//  Copyright 2010 Bad Guys Press. All rights reserved.
//

#import "CaponeAppDelegate.h"
#import "CaponeViewController.h"

@implementation CaponeAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize barButtonPlay;
@synthesize barButtonPause;
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
	//application.idleTimerDisabled = YES;  //Program was falling asleep during the show
    //[self.window addSubview:navigationController.view];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	//[viewController delegatePause];
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}
/*
- (void) beginInterruption {
    [navigationController bPlayPause];
}

- (void) endInterruption {
    [viewController bPlayPause];
}*/

- (BOOL) canBecomeFirstResponder{ //Allows media buttons
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	//[viewController delegateResume];
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[viewController release];
	[barButtonPlay release];
	[barButtonPause release];
    [navigationController release];
    [window release];
    [super dealloc];
}


@end
