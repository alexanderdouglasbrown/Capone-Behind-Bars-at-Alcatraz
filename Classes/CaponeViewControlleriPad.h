//
//  CaponeViewControlleriPad.h
//  Capone
//
//  Created by Alex Brown on 1/2/11.
//  Copyright 2011 Bad Guys Press. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CaponeViewControlleriPad : UIViewController {
	IBOutlet UIView *page0, *page1, *page2, *page3, *page4, *page5, *page6, *page7, *page8, *page9, *page10, *page11, *page12, *page13, *page14;
	IBOutlet UILabel *swipeLabel;
}
@property (nonatomic, retain) IBOutlet UIView *page0, *page1, *page2, *page3, *page4, *page5, *page6, *page7, *page8, *page9, *page10, *page11, *page12, *page13, *page14;
@property (nonatomic, retain) IBOutlet UILabel *swipeLabel;

@end
