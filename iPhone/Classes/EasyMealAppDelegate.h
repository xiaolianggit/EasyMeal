//
//  EasyMealAppDelegate.h
//  EasyMeal
//
//  Created by Liang Xiao on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "folderPath.h"
#import "globalURL.h"
@interface EasyMealAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
	
	NSMutableArray *menuArray;
	NSMutableDictionary *orderList;
	NSData *restInfoXMLData,*menuItemXMLData;
	
	BOOL isAdminMode;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) NSMutableArray *menuArray;
@property (nonatomic, retain) NSMutableDictionary *orderList;
@property (nonatomic, retain) NSData *restInfoXMLData,*menuItemXMLData;
@property (nonatomic, assign) BOOL isAdminMode;
- (void) clearExistingImages;
- (void) createDirectoryForImages;
- (void) refreshXMLData;
@end

