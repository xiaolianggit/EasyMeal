//
//  userMenu.h
//  testProject
//
//  Created by Liang Xiao on 17/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyMealAppDelegate.h"
#import "globalURL.h"
#import "menuItem.h"
#import "userMenuCell.h"
#import "userMenuDetailView.h"
#import "sharedFunctions.h"
#import "customTableView.h"


@interface userMenu : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate> {
	menuItem *item;
	NSMutableArray *menuArray;
	NSMutableString *currentElement;
	userMenuCell *localCell;
	UINavigationController *navigationController;
	NSIndexPath *selectedMenuItemIndexPath;
	EasyMealAppDelegate *appDelegate;
	customTableView *tableView;
}
@property (nonatomic, retain) menuItem *item;
@property (nonatomic, retain) NSMutableArray *menuArray;
@property (nonatomic, retain) NSMutableString *currentElement;
@property (nonatomic, retain) IBOutlet userMenuCell *localCell;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) NSIndexPath *selectedMenuItemIndexPath;
@property (nonatomic, retain) EasyMealAppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet customTableView *tableView;
- (void) parseMenu;
- (void) buttonClicked:(id)sender;
- (IBAction) showDetailView:(NSIndexPath*)indexPath;
- (void) customInitFunction;
- (void) addOrderItemToBasket;
- (void) showRandomMenuItem;
@end
