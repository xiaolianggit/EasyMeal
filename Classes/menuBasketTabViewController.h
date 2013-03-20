//
//  menuBasketTabViewController.h
//  testProject
//
//  Created by Liang Xiao on 12/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userMenu.h";
#import "userBasketListView.h"
#import "addUserMenuItemView.h"
#import "orderListView.h"
@protocol tabViewControllerDelegate

- (void) updateUserMenu;
- (void) emptyBasket;

@end

@interface menuBasketTabViewController : UIViewController <tabViewControllerDelegate,UIAlertViewDelegate>{
	UITabBarController *tabBarController;
	UIBarButtonItem *addButton,*refreshButton,*clearBasketButton;
	EasyMealAppDelegate *appDelegate;
}
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) UIBarButtonItem *addButton,*refreshButton,*clearBasketButton;
@property (nonatomic, retain) EasyMealAppDelegate *appDelegate;
- (void) addUserMenuItem;
- (void) clearBasketContent;
- (void) updateBadgeValue;
- (void) refreshOrderList;

@end
