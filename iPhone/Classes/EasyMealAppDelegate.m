//
//  EasyMealAppDelegate.m
//  EasyMeal
//
//  Created by Liang Xiao on 05/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EasyMealAppDelegate.h"

@implementation EasyMealAppDelegate

@synthesize window, navController;
@synthesize orderList,menuArray,restInfoXMLData,menuItemXMLData,isAdminMode;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    [self.window addSubview:navController.view];
	
    [self createDirectoryForImages];
	//[self clearExistingImages];
	
	NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
	self.orderList = tempDictionary;
	[tempDictionary release];
	[self refreshXMLData];
	
	self.isAdminMode = NO;
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void) clearExistingImages{
	NSString *fileNameForRestPicture = [[folderPath restPicturePath] stringByAppendingPathComponent:@"/restPic.jpg"];	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:fileNameForRestPicture]) {
		[fileManager removeItemAtPath:fileNameForRestPicture error:nil];
	}
}

- (void) createDirectoryForImages{
	NSString *RestPicturePath = [folderPath restPicturePath];
	NSString *MenuItemPicPath = [folderPath menuItemPicPath];
	NSString *OfflineDataPath = [folderPath offlineDataPath];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isDir = YES;
	if (![fileManager fileExistsAtPath:RestPicturePath isDirectory:&isDir]) {
		[fileManager createDirectoryAtPath:RestPicturePath withIntermediateDirectories:YES attributes:nil error:nil];
	}
	isDir = YES;
	if (![fileManager fileExistsAtPath:MenuItemPicPath isDirectory:&isDir]) {
		[fileManager createDirectoryAtPath:MenuItemPicPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
	if (![fileManager fileExistsAtPath:OfflineDataPath isDirectory:&isDir]) {
		[fileManager createDirectoryAtPath:OfflineDataPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
}

- (void) refreshXMLData{
	NSURL *restInfoURL = [globalURL restInfoGetURL];//XML location
	self.restInfoXMLData = [NSData dataWithContentsOfURL:restInfoURL];//get data from URL
	NSString *offlineRestInfoXMLPath = [[folderPath offlineDataPath] stringByAppendingPathComponent:@"restInfoXML"];
	if (self.restInfoXMLData) {
		[self.restInfoXMLData writeToFile:offlineRestInfoXMLPath atomically:YES];
	}
	else {
		self.restInfoXMLData = [NSData dataWithContentsOfFile:offlineRestInfoXMLPath];
	}
	
	NSURL *menuItemURL = [globalURL menuItemGetURL];
	self.menuItemXMLData = [NSData dataWithContentsOfURL:menuItemURL];
	NSString *offlineMenuItemXMLPath = [[folderPath offlineDataPath] stringByAppendingPathComponent:@"menuItemXML"];
	if (self.menuItemXMLData) {
		[self.menuItemXMLData writeToFile:offlineMenuItemXMLPath atomically:YES];
	}
	else {
		self.menuItemXMLData = [NSData dataWithContentsOfFile:offlineMenuItemXMLPath];
	}
}


- (void)dealloc {
	[restInfoXMLData release];
	[menuItemXMLData release];
    [window release];
	[menuArray release];
	[orderList release];
	[navController release];
    [super dealloc];
}


@end
