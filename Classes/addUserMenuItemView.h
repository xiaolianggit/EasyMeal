//
//  addUserMenuItemView.h
//  testProject
//
//  Created by Liang Xiao on 01/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalURL.h"
#import "textInputCell.h"
#import "EasyMealAppDelegate.h"
#import "menuItem.h"
#import "sharedFunctions.h"
#import "menuBasketTabViewController.h"
@protocol tabViewControllerDelegate;

@interface addUserMenuItemView : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UITableView *tView;
	UINavigationBar *navBar;
	UIBarButtonItem *cancelButton, *saveButton;
	
	NSMutableArray *stringArray;//for maintaining cell textfield values
	
	textInputCell *aCell;//custom cell for inputting text
	
	UITextField *aTextField;
	
	UITableViewCell *foodKindCell;
	UISegmentedControl *segControl;
	//ui elements for table header
	UIView *tableHeaderView;
	UIImageView *tableHeaderImageView;
	UIButton *chooseImageButton;
	BOOL imageChanged;
	id<tabViewControllerDelegate>delegate;

}
@property (nonatomic, retain) IBOutlet UITableView *tView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton, *saveButton;
@property (nonatomic, retain) NSMutableArray *stringArray;
@property (nonatomic, retain) IBOutlet textInputCell *aCell;
@property (nonatomic, retain) UITextField *aTextField;
@property (nonatomic, retain) IBOutlet UITableViewCell *foodKindCell;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, retain) IBOutlet UIView *tableHeaderView;
@property (nonatomic, retain) IBOutlet UIImageView *tableHeaderImageView;
@property (nonatomic, retain) IBOutlet UIButton *chooseImageButton;
@property (nonatomic, assign) id<tabViewControllerDelegate>delegate;
@property (assign) BOOL imageChanged;
- (IBAction) cancel;
- (IBAction) save;
- (void) checkEmptyCell:(id)sender;
- (IBAction) chooseImage;
- (void) uploadImageWithItemId:(int)itemId;
@end
