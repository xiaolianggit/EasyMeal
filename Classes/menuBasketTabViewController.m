//
//  menuBasketTabViewController.m
//  testProject
//
//  Created by Liang Xiao on 12/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "menuBasketTabViewController.h"


@implementation menuBasketTabViewController
@synthesize tabBarController,addButton,refreshButton,appDelegate,clearBasketButton;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


- (id)init{
	if (self = [super init]) {
		self.title = @"Menu";	
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.appDelegate = (EasyMealAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.view = tabBarController.view;

	
	NSArray *viewControllersArray = [self.tabBarController viewControllers];
	
	userMenu *childUserMenu = (userMenu*) [viewControllersArray objectAtIndex:0];
	childUserMenu.navigationController = self.navigationController;
	
	userBasketListView *childUserBasketListView = (userBasketListView*) [viewControllersArray objectAtIndex:1];
	childUserBasketListView.navigationController = self.navigationController;
	childUserBasketListView.delegate = self;
	
	orderListView *childOrderListView = (orderListView*) [viewControllersArray objectAtIndex:2];
	childOrderListView.navigationController = self.navigationController;

	
	[self updateBadgeValue];
}



- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	id selectedController = [self.tabBarController selectedViewController];
	if (selectedController == [[self.tabBarController viewControllers] objectAtIndex:0]) {
		if (appDelegate.isAdminMode) {
			if (!self.addButton) {
				UIBarButtonItem *tempaddButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUserMenuItem)];
				self.addButton = tempaddButton;
				[tempaddButton release];
			}
			self.navigationItem.rightBarButtonItem = self.addButton;
		}
	}
	else if(selectedController == [[self.tabBarController viewControllers] objectAtIndex:1]) {
		self.navigationItem.rightBarButtonItem = self.clearBasketButton;
		
	}
	else {
		self.navigationItem.rightBarButtonItem = self.refreshButton;
	}
}

- (void) addUserMenuItem{
	addUserMenuItemView *addView = [[addUserMenuItemView alloc] init];
	addView.delegate = self;
	[self presentModalViewController:addView animated:YES];
	[addView release];
}

- (void) updateUserMenu{
	userMenu *userMenuView = (userMenu*) [[self.tabBarController viewControllers] objectAtIndex:0];
	[userMenuView.tableView reloadData];
}
- (void) clearBasketContent{
	if ([self.appDelegate.orderList count]) {
		UIAlertView *alerView = [[[UIAlertView alloc] initWithTitle:@"Clear basket?" message:@"Remove all items in the basket?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Remove",nil]autorelease];
		[alerView show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex) {
		[self emptyBasket];
	}
}

- (void) emptyBasket{
	[self.appDelegate.orderList removeAllObjects];
	userBasketListView *view = (userBasketListView*)[self.tabBarController.viewControllers objectAtIndex:1];
	//[view.menuArray removeAllObjects];
	[view updateMenuArray];
	[view.tableView reloadData];
	[self updateBadgeValue];
}
- (void) refreshOrderList{
	orderListView *listView = (orderListView*)[[self.tabBarController viewControllers] objectAtIndex:2];
	[listView parseOrderList];
	[listView.tableView reloadData];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
	if (viewController == [[self.tabBarController viewControllers] objectAtIndex:1]) {
		//refresh the table view list
		userBasketListView *basketView = (userBasketListView*) viewController;
		[basketView updateMenuArray];
		[basketView.tableView reloadData];
		self.title = @"Basket";
		if (!self.clearBasketButton) {
			UIBarButtonItem *tempRefreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(clearBasketContent)]autorelease];
			self.clearBasketButton = tempRefreshButton;
		}
		self.navigationItem.rightBarButtonItem = self.clearBasketButton;
	}
	else if(viewController == [[self.tabBarController viewControllers] objectAtIndex:2]){
		self.title = @"Order";
		if (!self.refreshButton) {
			UIBarButtonItem *tempRefreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshOrderList)]autorelease];
			self.refreshButton = tempRefreshButton;
		}
		self.navigationItem.rightBarButtonItem = self.refreshButton;

	}
	else {
		self.title = @"Menu";
		if (self.appDelegate.isAdminMode) {
			self.navigationItem.rightBarButtonItem = self.addButton;
		}
		else {
			self.navigationItem.rightBarButtonItem = nil;
		}

	}


}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) updateBadgeValue{
	int count;
	UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:1];
	if (count = [appDelegate.orderList count]) {
		tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",count];
	}
	else {
		tabBarItem.badgeValue = nil;
	}

	
}


- (void)dealloc {
	[clearBasketButton release];
	[appDelegate release];
	[addButton release];
	[refreshButton release];
	[tabBarController release];
    [super dealloc];
}


@end
