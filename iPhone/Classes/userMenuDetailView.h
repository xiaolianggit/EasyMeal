//
//  userMenuDetailView.h
//  testProject
//
//  Created by Liang Xiao on 10/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "menuItem.h"
#import "EasyMealAppDelegate.h"
#import "sharedFunctions.h"

@interface userMenuDetailView : UIViewController<UIGestureRecognizerDelegate> {
	EasyMealAppDelegate *appDelegate;
	
	UIImageView *imageView;
	UILabel *itemIdLabel,*nameLabel,*priceLabel,*quantityLabel,*kindLabel;
	UITextView *introTextView;
	
	NSIndexPath *selectedIndexPath;

	UISwipeGestureRecognizer *swipeLeftRecognizer;
	
	menuItem *singleMenuItem;
	
	UIButton *setRecommended;
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *itemIdLabel,*priceLabel,*quantityLabel,*kindLabel;
@property (nonatomic, retain) IBOutlet UITextView *introTextView;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) menuItem *singleMenuItem;
@property (nonatomic, retain) EasyMealAppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UIButton *setRecommended;
- (void) refreshLabels;
- (id) initWithSelectedIndexPath:(NSIndexPath*)indexPath;
- (id) initWithMenuItem:(menuItem*)menuItem;
- (NSIndexPath*) findNextIndexPath:(NSIndexPath*)originalIndexPath;
- (NSIndexPath*) findPreviousIndexPath:(NSIndexPath*)originalIndexPath;
- (void) showNextItem;
- (void) showPreviousItem;
- (void) bounceCurrentItemLeft;
- (void) bounceCurrentItemRight;
- (IBAction) setPromoItem;
@end
