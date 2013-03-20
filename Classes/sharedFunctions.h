//
//  sharedFunctions.h
//  testProject
//
//  Created by Liang Xiao on 18/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyMealAppDelegate.h"
#import "menuItem.h"
#import "globalURL.h"
#import <MapKit/MapKit.h>

@interface sharedFunctions : NSObject {
}
+ (UIImage *) localImageForIndexPath:(NSIndexPath*)indexPath;
+ (menuItem*) menuItemAtIndexPath:(NSIndexPath*)indexPath;
+ (menuItem*) menuItemForItemID:(int)itemID;
+ (UIImage *) localImageForItemID:(int)itemID;
+ (void) updateMenuItemImages;
+ (void) getImageFromServerForMenuItem:(menuItem*)menuItem;
+ (NSData*) postDataString:(NSString*)dataString toURL:(NSURL*)url;
+ (NSData*) uploadImage:(UIImage*)image toURL:(NSURL*)url;
+ (CLLocationCoordinate2D) locationCoordinateForAddressString:(NSString*)addressString;
@end
