    //
//  CaponeViewControlleriPad.m
//  Capone
//
//  Created by Alex Brown on 1/2/11.
//  Copyright 2011 Bad Guys Press. All rights reserved.
//

#import "CaponeViewControlleriPad.h"
#import "CaponeViewController.h"


@implementation CaponeViewControlleriPad
@synthesize page0, page1, page2, page3, page4, page5, page6, page7, page8, page9, page10, page11, page12, page13, page14;
@synthesize swipeLabel;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[swipeLabel release];
	[page0 release];
	[page1 release];
	[page2 release];
	[page3 release];
	[page4 release];
	[page5 release];
	[page6 release];
	[page7 release];
	[page8 release];
	[page9 release];
	[page10 release];
	[page11 release];
	[page12 release];
	[page13 release];
	[page14 release];
    [super dealloc];
}


@end
