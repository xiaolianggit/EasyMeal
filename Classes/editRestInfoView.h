//
//  editRestInfoView.h
//  testProject
//
//  Created by Liang Xiao on 22/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalURL.h"
#import "textInputCell.h"
#import "sharedFunctions.h"
#import "welcome.h"

@protocol welcomeViewDelegate;

@interface editRestInfoView : UIViewController <UITextFieldDelegate>{
	id<welcomeViewDelegate> delegate;
	NSMutableArray *stringArray;//for maintaining cell textfield values
	UINavigationBar *navBar;
	UITableView *tView;
	UIBarButtonItem *doneButton,*cancelButton;
	
	UITextField *aTextField;//used for scrolling
	textInputCell *aCell;
}
@property (nonatomic, assign) id<welcomeViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *stringArray;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UITableView *tView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton, *cancelButton;
@property (nonatomic, retain) IBOutlet textInputCell *aCell;



- (IBAction) saveEdit: (id) sender;
- (IBAction) cancelEdit: (id) sender;
- (void) doneButtonControl: (id) sender;

	
@end
