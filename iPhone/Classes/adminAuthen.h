//
//  adminAuthen.h
//  EasyMeal
//
//  Created by Liang Xiao on 07/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sharedFunctions.h"
#import "globalURL.h"
#import "welcome.h"
@protocol welcomeViewDelegate;

@interface adminAuthen : UIViewController<UITextFieldDelegate> {
	UITableViewCell *usernameCell,*passwordCell;
	UILabel *usernameLabel,*passwordLabel;
	UITextField *usernameTF,*passwordTF;
	UITableView *tableView;
	UIBarButtonItem *cancel,*go;
	id<welcomeViewDelegate>delegate;
}
@property (nonatomic, retain) IBOutlet UITableViewCell *usernameCell,*passwordCell;
@property (nonatomic, retain) IBOutlet UITextField *usernameTF,*passwordTF;
@property (nonatomic, retain) IBOutlet UILabel *usernameLabel,*passwordLabel;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancel,*go;
@property (nonatomic, assign) id<welcomeViewDelegate>delegate;
- (IBAction) dismissView;
- (IBAction) authenticate;
@end
