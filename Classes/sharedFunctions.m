//
//  sharedFunctions.m
//  testProject
//
//  Created by Liang Xiao on 18/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "sharedFunctions.h"


@implementation sharedFunctions
+ (UIImage *) localImageForIndexPath:(NSIndexPath*)indexPath{
	NSString *folderPathForMenuItemPic = [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
	menuItem *item = [self menuItemAtIndexPath:indexPath];
	
	if (item) {//check if item is nil
		int menuItemId = item.itemId;
		NSString *filePath = [NSString stringWithFormat:@"%@/%d.jpg",folderPathForMenuItemPic,menuItemId];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		//check if image exists locally
		if ([fileManager fileExistsAtPath:filePath]) {
			UIImage *localImage = [UIImage imageWithContentsOfFile:filePath];
			return localImage;
		}
	}
	return nil;
}

+ (menuItem*) menuItemAtIndexPath:(NSIndexPath*)indexPath{
	EasyMealAppDelegate *appDelegat = [[UIApplication sharedApplication] delegate];
	NSMutableArray *localMenuArray = appDelegat.menuArray;
	if (localMenuArray) {//check if the menu array has been initialized
		menuItem *tempMenuItem = [[localMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		return tempMenuItem;
	}
	else {
		return nil;
	}
}

+ (menuItem*) menuItemForItemID:(int)itemID{
	EasyMealAppDelegate *appDelegat = [[UIApplication sharedApplication] delegate];
	NSMutableArray *localMenuArray = appDelegat.menuArray;
	for (NSMutableArray *tempArray in localMenuArray)
		for (menuItem* tempMenuItem in tempArray)
			if (tempMenuItem.itemId == itemID) {
				return tempMenuItem;
			}
	return nil;
}

+ (UIImage *) localImageForItemID:(int)itemID{
	NSString *folderPathForMenuItemPic = [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
	NSString *filePath = [NSString stringWithFormat:@"%@/%d.jpg",folderPathForMenuItemPic,itemID];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//check if image exists locally
	if ([fileManager fileExistsAtPath:filePath]) {
		UIImage *localImage = [UIImage imageWithContentsOfFile:filePath];
		return localImage;
	}
	else {
		return nil;
	}
}


+ (void) updateMenuItemImages{
	EasyMealAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSString *folderPathForMenuItemPic = [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
	NSLog(@"folder path:%@",folderPathForMenuItemPic);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//delete obsolete files
	NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:folderPathForMenuItemPic error:nil];
	NSMutableArray *copyMenuArray = [NSMutableArray array];
	for (NSMutableArray *midLevelArray in appDelegate.menuArray)
		for (menuItem *tempMenuItem in midLevelArray)
			[copyMenuArray addObject:tempMenuItem];
	
	for (NSString *localFileName in fileArray){
		BOOL shouldDelete = YES;
		for (menuItem *currentMenuItem in copyMenuArray){
			NSString *fileNameFromItemId = [NSString stringWithFormat:@"%d.jpg",currentMenuItem.itemId];
			if ([localFileName isEqualToString:fileNameFromItemId]) {
				shouldDelete = NO;
				[copyMenuArray removeObject:currentMenuItem];
				break;
			}
		}
		if (shouldDelete) {
			NSString *filePath = [NSString stringWithFormat:@"%@/%@",folderPathForMenuItemPic,localFileName];
			[fileManager removeItemAtPath:filePath error:nil];
		}
	}
	//download new files
	for(menuItem *tempItem in copyMenuArray){
		[self performSelectorInBackground:@selector(getImageFromServerForMenuItem:) withObject:tempItem];
	}
}
+ (void) getImageFromServerForMenuItem:(menuItem*)menuitem{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	assert( pool != nil);
	int itemID = menuitem.itemId;

	NSString *folderPathForMenuItemPic = [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
	NSString *filePath = [NSString stringWithFormat:@"%@/%d.jpg",folderPathForMenuItemPic,itemID];
	NSURL *url = [globalURL menuItemPicURLAtItemID:itemID];
	NSData *tempImageData = [NSData dataWithContentsOfURL:url];
	if (tempImageData != nil) {
		[tempImageData writeToFile:filePath atomically:YES];
	}
	[pool drain];
}

+ (NSData*) postDataString:(NSString*)dataString toURL:(NSURL*)url{
	NSData *bodyData = [NSData dataWithBytes:[dataString UTF8String] length:[dataString length]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPBody:bodyData];
	[request setHTTPMethod:@"POST"];
	return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

+ (NSData*) uploadImage:(UIImage*)image toURL:(NSURL*)url{
	NSData *imgData = UIImageJPEGRepresentation(image, 70);
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	NSString *boundary = @"---------------------------14737809831466499882746641449";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"restPic.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:imgData];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPBody:body];
	//NSData *returnData = 
	return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];	
}

+ (CLLocationCoordinate2D) locationCoordinateForAddressString:(NSString*)addressString{
	NSURL* url = [globalURL mapURLForAddressString:addressString];
	NSString *locationString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	NSArray *returnedItems = [locationString componentsSeparatedByString:@","];
	double latitude=0,longitude=0;
	if ([returnedItems count] >= 4 && [[returnedItems objectAtIndex:0] isEqualToString:@"200"]) {
		latitude = [[returnedItems objectAtIndex:2] doubleValue];
		longitude = [[returnedItems objectAtIndex:3] doubleValue];
	}
	
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	
	return location;
}


@end
