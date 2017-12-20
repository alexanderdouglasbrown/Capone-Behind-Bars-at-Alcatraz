//
//  CaponeViewController.m
//  Capone
//
//  Created by Alex Brown on 12/11/10.
//  Copyright 2010 Bad Guys Press. All rights reserved.
//

#import "CaponeViewController.h"
#import "credits.h"
#import "iPadCredits.h"
#import "CaponeAppDelegate.h"

#import <MediaPlayer/MediaPlayer.h>

#define appDelegate (CaponeAppDelegate *) [[UIApplication sharedApplication] delegate]
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

//	NSLog(@"Retain count: %d", [currentView retainCount]);     Retain count reference

//Variables
BOOL firstSwipe = YES;
BOOL isPaused = NO;
BOOL finishedAudio = NO;
BOOL ignoreMediaKeys = NO;
int pageNumber = 0;
const int MAX_PAGE = 14;

@implementation CaponeViewController;
@synthesize voiceAudio;
@synthesize scrollViewPage1, scrollViewPage2, scrollViewPage5, scrollViewPage6, scrollViewPage7, scrollViewPage8, scrollViewPage9,
scrollViewPage10, scrollViewPage11, scrollViewPage12;
@synthesize textViewPage3, textViewPage4, textViewPage13;
@synthesize page0, page1, page2, page3, page4, page5, page6, page7, page8, page9, page10, page11, page12, page13, page14;
@synthesize swipeLabel, infoButton;


- (void)setPage {
    if (firstSwipe) {
        swipeLabel.hidden = YES;
        firstSwipe = NO;
    }
    [voiceAudio stop];
    self.view.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = YES; ///Unselect highlighted text
    finishedAudio = NO;
    switch (pageNumber) {
        case 0:
            isPaused = NO;
            [self.view addSubview:page0];
            break;
        case 1:
            [self.view addSubview:page1];
            break;
        case 2:
            [self.view addSubview:page2];
            break;
        case 3:
            [self.view addSubview:page3];
            break;
        case 4:
            [self.view addSubview:page4];
            break;
        case 5:
            [self.view addSubview:page5];
            break;
        case 6:
            [self.view addSubview:page6];
            break;
        case 7:
            [self.view addSubview:page7];
            break;
        case 8:
            [self.view addSubview:page8];
            break;
        case 9:
            [self.view addSubview:page9];
            break;
        case 10:
            [self.view addSubview:page10];
            break;
        case 11:
            [self.view addSubview:page11];
            break;
        case 12:
            [self.view addSubview:page12];
            break;
        case 13:
            [self.view addSubview:page13];
            break;
        case 14:
            [self.view addSubview:page14];
            break;
        default:
            break;
    }
}

- (void)swipeLeft {  ///Next page
    if (pageNumber < MAX_PAGE){
        pageNumber++;
        [self setPage];
        if (pageNumber == 1)
            [self.navigationItem setRightBarButtonItem:[appDelegate barButtonPlay] animated:YES];
        //Page animation
        ignoreMediaKeys = YES;
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationFinished)];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        [UIView commitAnimations];
    }
}
- (void)swipeRight {  //Previous page
    if (pageNumber > 0){
        pageNumber--;
        [self setPage];
        //Page animation
        ignoreMediaKeys = YES;
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationFinished)];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        [UIView commitAnimations];
    }
}


- (void)bRewind {
    pageNumber = 0;
    [self setPage];
    ignoreMediaKeys = YES;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (void)bCredits {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { //check if iPad, if not load iPhone credits page
        iPadCredits *creditsVC = [[iPadCredits alloc] initWithNibName:@"iPadCredits" bundle:nil];
        [self.navigationController pushViewController:creditsVC animated:YES];
        [creditsVC release];
    } else {
        credits *creditsVC = [[credits alloc] initWithNibName:@"credits" bundle:nil];
        [self.navigationController pushViewController:creditsVC animated:YES];
        [creditsVC release];
    }
}

- (void)bPlayPause{
    if (self.navigationItem.rightBarButtonItem.enabled) {  //Fix user may sometimes be able to press the button even when disabled.
        if (pageNumber == 0){
            [self swipeLeft];
            return;
        }
        if (isPaused) {
            [self.navigationItem setRightBarButtonItem:[appDelegate barButtonPlay] animated:YES];
            isPaused = NO;
            [voiceAudio play];
        }else{
            [self.navigationItem setRightBarButtonItem:[appDelegate barButtonPause] animated:YES];
            isPaused = YES;
            [voiceAudio pause];
        }
    }
}

- (void)animationFinished {
    [self playAudio];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    ignoreMediaKeys = NO;
    if (pageNumber == 0) {
        self.navigationItem.leftBarButtonItem.enabled = NO;
        [self.navigationItem setRightBarButtonItem:[appDelegate barButtonPause] animated:YES];
    }else{
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
    switch (pageNumber) {
        case 0:
            [self.navigationItem setTitle:@"Capone"];
            break;
        case 1:
            [self.navigationItem setTitle:@"Page 1 of 14"];
            break;
        case 2:
            [self.navigationItem setTitle:@"Page 2 of 14"];
            break;
        case 3:
            [self.navigationItem setTitle:@"Page 3 of 14"];
            break;
        case 4:
            [self.navigationItem setTitle:@"Page 4 of 14"];
            break;
        case 5:
            [self.navigationItem setTitle:@"Page 5 of 14"];
            break;
        case 6:
            [self.navigationItem setTitle:@"Page 6 of 14"];
            break;
        case 7:
            [self.navigationItem setTitle:@"Page 7 of 14"];
            break;
        case 8:
            [self.navigationItem setTitle:@"Page 8 of 14"];
            break;
        case 9:
            [self.navigationItem setTitle:@"Page 9 of 14"];
            break;
        case 10:
            [self.navigationItem setTitle:@"Page 10 of 14"];
            break;
        case 11:
            [self.navigationItem setTitle:@"Page 11 of 14"];
            break;
        case 12:
            [self.navigationItem setTitle:@"Page 12 of 14"];
            break;
        case 13:
            [self.navigationItem setTitle:@"Page 13 of 14"];
            break;
        case 14:
            [self.navigationItem setTitle:@"Page 14 of 14"];
            break;
        default:
            break;
    }
}

- (void)playAudio {
    if (pageNumber != 0) {
        [voiceAudio release];
        NSURL *audioURL;
        switch (pageNumber) {
            case 1:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage1" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 2:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage2" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 3:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage3" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 4:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage4" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 5:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage5" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 6:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage6" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 7:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage7" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 8:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage8" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 9:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage9" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 10:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage10" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 11:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage11" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 12:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage12" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 13:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage13" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            case 14:
                audioURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"caponepage14" ofType:@"m4a"]];
                voiceAudio = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:audioURL error:nil];
                break;
            default:
                audioURL = nil;
                break;
        }
        voiceAudio.delegate = self;
        [audioURL release];
        if(!isPaused)
            [voiceAudio play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (pageNumber == MAX_PAGE) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        finishedAudio = YES;
    }else {
        [self swipeLeft];
    }
    
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    [self bPlayPause];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
    [self bPlayPause];
}

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self canBecomeFirstResponder])
        [self becomeFirstResponder];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    MPRemoteCommandCenter *remoteCommandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    [[remoteCommandCenter togglePlayPauseCommand] addTarget:self action:@selector(bPlayPause)];
    [[remoteCommandCenter playCommand] addTarget:self action:@selector(bPlayPause)];
    [[remoteCommandCenter pauseCommand] addTarget:self action:@selector(bPlayPause)];
    [[remoteCommandCenter nextTrackCommand] addTarget:self action:@selector(swipeLeft)];
    [[remoteCommandCenter previousTrackCommand] addTarget:self action:@selector(swipeRight)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    int contentOffset = 88; //Make up for transitioning from 3.5" to 4" screen
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")){
        contentOffset -= 64;
    }
    
    if ([[UIScreen mainScreen] bounds].size.height == 568){ //Check for new aspect ratio
        CGRect fixUI;
        fixUI = [infoButton frame];
        fixUI.origin.y += 88;
        [infoButton setFrame:fixUI];
        fixUI = [swipeLabel frame];
        fixUI.origin.y += 88;
        [swipeLabel setFrame:fixUI];
    }else if ([[UIScreen mainScreen] bounds].size.height == 480){
        CGRect scrollFrame;
        scrollFrame.size = CGSizeMake(320,416);
        [scrollViewPage1 setFrame: scrollFrame];
        [scrollViewPage2 setFrame: scrollFrame];
        [scrollViewPage5 setFrame: scrollFrame];
        [scrollViewPage6 setFrame: scrollFrame];
        [scrollViewPage7 setFrame: scrollFrame];
        [scrollViewPage8 setFrame: scrollFrame];
        [scrollViewPage9 setFrame: scrollFrame];
        [scrollViewPage10 setFrame: scrollFrame];
        [scrollViewPage11 setFrame: scrollFrame];
        [scrollViewPage12 setFrame: scrollFrame];
        [textViewPage3 setFrame: scrollFrame];
        [textViewPage4 setFrame: scrollFrame];
        [textViewPage13 setFrame: scrollFrame];
        
    }
    [scrollViewPage1 setScrollEnabled:YES];
    [scrollViewPage1 setContentSize:CGSizeMake(320, 1220 - contentOffset)];
    [scrollViewPage2 setScrollEnabled:YES];
    [scrollViewPage2 setContentSize:CGSizeMake(320, 1125 - contentOffset)];
    [scrollViewPage5 setScrollEnabled:YES];
    [scrollViewPage5 setContentSize:CGSizeMake(320, 1145 - contentOffset)];
    [scrollViewPage6 setScrollEnabled:YES];
    [scrollViewPage6 setContentSize:CGSizeMake(320, 1395 - contentOffset)];
    [scrollViewPage7 setScrollEnabled:YES];
    [scrollViewPage7 setContentSize:CGSizeMake(320, 1330 - contentOffset)];
    [scrollViewPage8 setScrollEnabled:YES];
    [scrollViewPage8 setContentSize:CGSizeMake(320, 1330 - contentOffset)];
    [scrollViewPage9 setScrollEnabled:YES];
    [scrollViewPage9 setContentSize:CGSizeMake(320, 1030 - contentOffset)];
    [scrollViewPage10 setScrollEnabled:YES];
    [scrollViewPage10 setContentSize:CGSizeMake(320, 1240 - contentOffset)];
    [scrollViewPage11 setScrollEnabled:YES];
    [scrollViewPage11 setContentSize:CGSizeMake(320, 1230 - contentOffset)];
    [scrollViewPage12 setScrollEnabled:YES];
    [scrollViewPage12 setContentSize:CGSizeMake(320, 1230 - contentOffset)];
    
    [[appDelegate barButtonPlay] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(bPlayPause)];
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
    
    [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    /*
     // Return YES for supported orientations
     return (interfaceOrientation == UIInterfaceOrientationPortrait);*/
    if (interfaceOrientation==UIInterfaceOrientationPortrait)
        return YES;
    return NO;
    /*
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
     return YES;
     }else{
     return NO;
     }
     */
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
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
    [scrollViewPage1 release];
    [scrollViewPage2 release];
    [scrollViewPage5 release];
    [scrollViewPage6 release];
    [scrollViewPage7 release];
    [scrollViewPage8 release];
    [scrollViewPage9 release];
    [scrollViewPage10 release];
    [scrollViewPage11 release];
    [scrollViewPage12 release];
    [textViewPage13 release];
    [textViewPage3 release];
    [textViewPage4 release];
    [infoButton release];
    [voiceAudio release];
    [swipeLabel release];
    [super dealloc];
}

@end
