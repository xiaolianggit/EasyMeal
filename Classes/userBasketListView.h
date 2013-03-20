//
//  userBasketListView.h
//  testProject
//
//  Created by Liang Xiao on 14/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyMealAppDelegate.h"
#import "menuItem.h"
#import "userMenuDetailView.h"
#import "basketViewCell.h"
#import "sharedFunctions.h"
#import "userInfo.h"
#import "menuBasketTabViewController.h"
@protocol tabViewControllerDelegate;


@interface userBasketListView : UIViewController {
	EasyMealAppDelegate *appDelegate;
	NSArray *menuArray;
	UINavigationController *navigationController;
	basketViewCell *localCell;
	UITableViewCell *proceedTableViewCell;
	UIButton *proceedButton;
	UITableView *tableView;
	id<tabViewControllerDelegate>delegate;
}
@property (nonatomic, retain) EasyMealAppDelegate *appDelegate; 
@property (nonatomic, retain) NSArray *menuArray;
@property (nonatomic ,retain) UINavigationController *navigationController;
@property (nonatomic ,retain) IBOutlet basketViewCell *localCell;
@property (nonatomic ,retain) IBOutlet UITableViewCell *proceedTableViewCell;
@property (nonatomic ,retain) IBOutlet UIButton *proceedButton;
@property (nonatomic ,retain) IBOutlet UITableView *tableView;
@property (nonatomic ,assign) id<tabViewControllerDelegate>delegate;
- (void) updateMenuArray;
- (float) calculateTotalPrice;
- (IBAction) proceed;
@end
