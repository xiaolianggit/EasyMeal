//
//  userInfo.h
//  testProject
//
//  Created by Liang Xiao on 24/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "textInputCell.h"
#import "EasyMealAppDelegate.h"
#import "menuItem.h"
#import "globalURL.h"
#import "sharedFunctions.h"
#import "menuBasketTabViewController.h"
@protocol tabViewControllerDelegate;

@interface userInfo : UIViewController <UITextFieldDelegate>{
	UINavigationBar *navBar;
	UITableView *tView;
	UIBarButtonItem *cancelButton,*saveButton;
	textInputCell *localCell;
	//UIView *tableFooterView;
	UITextField *aTextField;
	NSMutableArray *stringArray;
	id<tabViewControllerDelegate>delegate;
}
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UITableView *tView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton,*saveButton;
@property (nonatomic, retain) IBOutlet textInputCell *localCell;
//@property (nonatomic, retain) IBOutlet UIView *tableFooterView;
@property (nonatomic, retain) NSMutableArray *stringArray;
@property (nonatomic, assign) id<tabViewControllerDelegate>delegate;
- (IBAction) cancel;
- (IBAction) save;
@end
