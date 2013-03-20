//
//  globalURL.h
//  testProject
//
//  Created by Liang Xiao on 12/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyMealAppDelegate.h"

@interface globalURL : NSObject {
}

+ (NSURL*)restInfoGetURL;
+ (NSURL*)restInfoPicURL;
+ (NSURL*)restInfoPicUploaderURL;
+ (NSURL*)restInfoUpdateURL;

+ (NSURL*) promoItemGetURL;

+ (NSURL*)menuItemGetURL;
+ (NSURL*)menuItemDeleteURLAtItemID:(int)itemID;
+ (NSURL*)menuItemPicURLAtItemID:(int)itemID;
+ (NSURL*)menuItemAddURL;
+ (NSURL*)menuItemPicUploaderURLAtItemID:(int)itemID;
+ (NSURL*)mapURLForAddressString:(NSString*)addressString;
+ (NSURL*)orderListAddURL;
+ (NSURL*)orderListGetURL;
+ (NSURL*)orderStatusUpdateURLForOrderID:(int)orderID newStatus:(int)status;
+ (NSURL*)authenURL;
@end
