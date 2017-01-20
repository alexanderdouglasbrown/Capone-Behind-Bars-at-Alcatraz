//
//  CaponeViewController.h
//  Capone
//
//  Created by Alex Brown on 12/11/10.
//  Copyright 2010 Bad Guys Press. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>


@interface CaponeViewController : UIViewController <AVAudioPlayerDelegate> {
	
	AVAudioPlayer *voiceAudio;
	IBOutlet UIView *page0, *page1, *page2, *page3, *page4, *page5, *page6, *page7, *page8, *page9, *page10, *page11, *page12, *page13, *page14;
	IBOutlet UIScrollView *scrollViewPage1, *scrollViewPage2, *scrollViewPage5, *scrollViewPage6, *scrollViewPage7, *scrollViewPage8, *scrollViewPage9, *scrollViewPage10,
	*scrollViewPage11, *scrollViewPage12;
    IBOutlet UITextView *textViewPage3, *textViewPage4, *textViewPage13;
	IBOutlet UILabel *swipeLabel;
    IBOutlet UIButton *infoButton;

}

@property (nonatomic, retain) AVAudioPlayer *voiceAudio;
@property (nonatomic, retain) IBOutlet UIView *page0, *page1, *page2, *page3, *page4, *page5, *page6, *page7, *page8, *page9, *page10, *page11, *page12, *page13, *page14;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollViewPage1, *scrollViewPage2, *scrollViewPage5, *scrollViewPage6, *scrollViewPage7, *scrollViewPage8,
*scrollViewPage9, *scrollViewPage10, *scrollViewPage11, *scrollViewPage12;
@property (nonatomic, retain) IBOutlet UITextView *textViewPage3, *textViewPage4, *textViewPage13;
@property (nonatomic, retain) UILabel *swipeLabel;
@property (nonatomic, retain) UIButton *infoButton;

- (IBAction) bRewind;
- (IBAction) bPlayPause;
- (IBAction) bCredits;

- (void)playAudio;
- (void)setPage;
- (void)swipeLeft;
- (void)swipeRight;
- (void)bRewind;
- (void)bPlayPause;
- (void)bCredits;
- (void)animationFinished;
//- (void)delegatePause;
//- (void)delegateResume;

@end