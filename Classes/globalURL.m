//
//  globalURL.m
//  testProject
//
//  Created by Liang Xiao on 12/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "globalURL.h"

//NSString *rootURL = @"http://localhost:8888/EIEFYP/";
NSString *rootURL = @"http://polyueiefyp.erufa.com/EIEFYP/";

//url strings for rest info
NSString *restInfoGet = @"rest_info_get.php";
NSString *restInfoUpdate = @"rest_info_update.php";
NSString *restInfoPicUploader = @"rest_info_pic_uploader.php";
NSString *restPicFile = @"restPicture/restPic.jpg";

NSString *promoItemGet = @"promo_item_get.php";

//url strings for menu items
NSString *menuItemGet = @"menu_info_get.php";
NSString *menuItemDelete = @"menu_item_delete.php?id=";
NSString *menuItemPic = @"menuItemPic/";
NSString *menuItemAdd = @"menu_item_add.php";
NSString *menuItemUploader = @"menu_item_pic_uploader.php?itemID=";

//url strings for order list
NSString *orderListAdd = @"order_list_add.php";
NSString *orderListGet = @"order_list_get_xml.php";
NSString *orderStatusUpdate = @"order_list_update_status.php";

//authenticate server
NSString *authen = @"authen.php";


@implementation globalURL
//return rest info urls
+ (NSURL*)restInfoGetURL{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,restInfoGet];
	return [NSURL URLWithString:tempURLString];
}

+ (NSURL*)restInfoPicURL{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,restPicFile];
	return [NSURL URLWithString:tempURLString];
}
+ (NSURL*)restInfoPicUploaderURL{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,restInfoPicUploader];
	return [NSURL URLWithString:tempURLString];
}

+ (NSURL*)restInfoUpdateURL{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,restInfoUpdate];
	return [NSURL URLWithString:tempURLString];
}

//return menu item urls
+ (NSURL*)menuItemGetURL{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,menuItemGet];
	return [NSURL URLWithString:tempURLString];
}
+ (NSURL*)menuItemDeleteURLAtItemID:(int)itemID{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@%d",rootURL,menuItemDelete,itemID];
	return [NSURL URLWithString:tempURLString];
}

+ (NSURL*)menuItemPicURLAtItemID:(int)itemID{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@%d.jpg",rootURL,menuItemPic,itemID];
	return [NSURL URLWithString:tempURLString];
}
+ (NSURL*)menuItemAddURL{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,menuItemAdd];
	return [NSURL URLWithString:tempURLString];
}
+ (NSURL*)menuItemPicUploaderURLAtItemID:(int)itemID{
	NSString* tempURLString = [NSString stringWithFormat:@"%@%@%d",rootURL,menuItemUploader,itemID];
	return [NSURL URLWithString:tempURLString];
}

+ (NSURL*) promoItemGetURL{
	NSString *tempURLString = [rootURL stringByAppendingPathComponent:promoItemGet];
	return [NSURL URLWithString:tempURLString];
}


//map kit url

+ (NSURL*)mapURLForAddressString:(NSString*)addressString{
	NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",addressString];
	NSString* convertedURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL* url = [NSURL URLWithString:convertedURLString];
	return url;
}
//order list url

+ (NSURL*)orderListAddURL{
	NSString *tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,orderListAdd];
	return [NSURL URLWithString:tempURLString];
}

+ (NSURL*)orderListGetURL{
	NSString *tempURLString;
	EasyMealAppDelegate *appDelegate = (EasyMealAppDelegate*)[[UIApplication sharedApplication] delegate];
	if (appDelegate.isAdminMode) {
		tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,orderListGet];
	}
	else {
		NSString *udidString = [[UIDevice currentDevice] uniqueIdentifier];
		tempURLString = [NSString stringWithFormat:@"%@%@?udid=%@",rootURL,orderListGet,udidString];
	}

	
	return [NSURL URLWithString:tempURLString];
}

+ (NSURL*)orderStatusUpdateURLForOrderID:(int)orderID newStatus:(int)status{
	NSString *tempURLString = [NSString stringWithFormat:@"%@%@?orderID=%d&status=%d",rootURL,orderStatusUpdate,orderID,status];
	NSLog(@"string:%@",tempURLString);
	return [NSURL URLWithString:tempURLString];
}

//authenticate server url
+ (NSURL*)authenURL{
	NSString *tempURLString = [NSString stringWithFormat:@"%@%@",rootURL,authen];
	return [NSURL URLWithString:tempURLString];
}

@end
